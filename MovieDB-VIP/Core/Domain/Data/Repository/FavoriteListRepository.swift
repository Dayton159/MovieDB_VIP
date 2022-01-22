//
//  FavoriteListRepository.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//

import Combine

protocol FavoriteListRepositoryProtocol: AnyObject {
  func getAllFavorites() -> AnyPublisher<[MovieEntity], APIServiceError>
}

final class FavoriteListRepository {
  private let _dataSource: FavoriteListDataSourceProtocol
  private let _mapper: (([CDMovieFavorite]) -> [MovieEntity])
  
  init(dataSource: FavoriteListDataSourceProtocol, mapper: @escaping (([CDMovieFavorite]) -> [MovieEntity])) {
    self._dataSource = dataSource
    self._mapper = mapper
  }
}

extension FavoriteListRepository: FavoriteListRepositoryProtocol {
  func getAllFavorites() -> AnyPublisher<[MovieEntity], APIServiceError> {
    self._dataSource
      .getAllFavorites()
      .map { self._mapper($0)}
      .eraseToAnyPublisher()
  }
}
