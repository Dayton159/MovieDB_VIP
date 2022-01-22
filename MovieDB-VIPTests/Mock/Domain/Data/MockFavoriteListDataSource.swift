//
//  MockFavoriteListDataSource.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 21/01/22.
//

import Combine
import CoreData
@testable import MovieDB_VIP

class MockFavoriteListDataSource: FavoriteListDataSourceProtocol {

  var expError: Error?
  private let _context: NSManagedObjectContext

  init(context: NSManagedObjectContext) {
    _context = context
  }

  func getAllFavorites() -> AnyPublisher<[CDMovieFavorite], APIServiceError> {
    return Future<[CDMovieFavorite], APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(CDMovieFavorite.dummy(context: self._context)))
      }
    }
    .eraseToAnyPublisher()
  }
}
