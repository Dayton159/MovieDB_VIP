//
//  MockFavoriteListRepository.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 21/01/22.
//

import Combine
@testable import MovieDB_VIP

class MockFavoriteListRepository: FavoriteListRepositoryProtocol {

  var expError: Error?
  
  func getAllFavorites() -> AnyPublisher<[MovieEntity], APIServiceError> {
    return Future<[MovieEntity], APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(MovieEntity.dummyLocal))
      }
    }
    .eraseToAnyPublisher()
  }
}
