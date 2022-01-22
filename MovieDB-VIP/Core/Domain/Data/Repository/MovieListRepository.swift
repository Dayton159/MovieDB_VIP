//
//  MovieListRepository.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

import Combine

protocol MovieListRepositoryProtocol: AnyObject {
  func getPopularMovies() -> AnyPublisher<[MovieEntity], APIServiceError>
  func getTopRatedMovies() -> AnyPublisher<[MovieEntity], APIServiceError>
  func getNowPlayingMovies() -> AnyPublisher<[MovieEntity], APIServiceError>
}

final class MovieListRepository {
  private let _dataSource: MovieListDataSourceProtocol
  private let _mapper: (([MovieResponse]) -> [MovieEntity])
  
  init(dataSource: MovieListDataSourceProtocol, mapper: @escaping (([MovieResponse]) -> [MovieEntity])) {
    self._dataSource = dataSource
    self._mapper = mapper
  }
}

extension MovieListRepository: MovieListRepositoryProtocol {
  func getPopularMovies() -> AnyPublisher<[MovieEntity], APIServiceError> {
    self._dataSource
      .getPopularMovies()
      .map { self._mapper($0) }
      .eraseToAnyPublisher()
  }
  
  func getTopRatedMovies() -> AnyPublisher<[MovieEntity], APIServiceError> {
    self._dataSource
      .getTopRatedMovies()
      .map { self._mapper($0) }
      .eraseToAnyPublisher()
  }
  
  func getNowPlayingMovies() -> AnyPublisher<[MovieEntity], APIServiceError> {
    self._dataSource
      .getNowPlayingMovies()
      .map { self._mapper($0) }
      .eraseToAnyPublisher()
  }
}
