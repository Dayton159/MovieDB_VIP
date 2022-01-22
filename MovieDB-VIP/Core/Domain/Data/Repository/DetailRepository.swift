//
//  ReviewListRepository.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import Combine

enum DataRequestSource {
  case network
  case local
}

protocol DetailRepositoryProtocol: AnyObject {
  func getMovieReviews(source: DataRequestSource) -> AnyPublisher<[ReviewEntity], APIServiceError>
  func saveMovie(movie: DetailEntity) -> AnyPublisher<Void, APIServiceError>
  func deleteFavoriteMovie() -> AnyPublisher<Void, APIServiceError>
  func isMovieFavorited() -> AnyPublisher<Bool, APIServiceError>
}

final class DetailRepository {
  private let _remote: DetailDataSourceProtocol
  private let _local: DetailFavDataSourceProtocol
  private let _mapperRemote: (([ReviewResponse]) -> [ReviewEntity])
  private let _mapperLocal: (([CDReview]) -> [ReviewEntity])
  
  init(remote: DetailDataSourceProtocol, local: DetailFavDataSourceProtocol, mapperRemote: @escaping (([ReviewResponse]) -> [ReviewEntity]), mapperLocal: @escaping (([CDReview]) -> [ReviewEntity])) {
    self._remote = remote
    self._local = local
    self._mapperRemote = mapperRemote
    self._mapperLocal = mapperLocal
  }
}

extension DetailRepository: DetailRepositoryProtocol {
  func deleteFavoriteMovie() -> AnyPublisher<Void, APIServiceError> {
    self._local
      .deleteFavoriteMovie()
      .eraseToAnyPublisher()
  }
  
  func isMovieFavorited() -> AnyPublisher<Bool, APIServiceError> {
    self._local
      .isMovieFavorited()
      .eraseToAnyPublisher()
  }
  
  func saveMovie(movie: DetailEntity) -> AnyPublisher<Void, APIServiceError> {
    self._local
      .saveMovie(movie: movie)
      .eraseToAnyPublisher()
  }
  
  func getMovieReviews(source: DataRequestSource) -> AnyPublisher<[ReviewEntity], APIServiceError> {
    switch source {
    case .network:
     return self._remote
        .getMovieReviews()
        .map { self._mapperRemote($0)}
        .eraseToAnyPublisher()
    case .local:
     return self._local
        .getMovieReviews()
        .map { self._mapperLocal($0) }
        .eraseToAnyPublisher()
    }
  }
}
