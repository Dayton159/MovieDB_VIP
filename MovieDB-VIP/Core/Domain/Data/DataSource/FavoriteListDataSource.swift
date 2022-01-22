//
//  FavoriteListDataSource.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//

import CoreData
import Combine

protocol FavoriteListDataSourceProtocol: AnyObject {
  func getAllFavorites() -> AnyPublisher<[CDMovieFavorite], APIServiceError>
}

final class FavoriteListDataSource {
  private let _request: FavoriteListRequest
  private let _context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext, request: FavoriteListRequest) {
    _context = context
    _request = request
  }
}

extension FavoriteListDataSource: FavoriteListDataSourceProtocol {
  func getAllFavorites() -> AnyPublisher<[CDMovieFavorite], APIServiceError> {
    return Future<[CDMovieFavorite], APIServiceError> { completion in
      self._context.perform {
        let fetchRequest = self._request.makeFetchRequest()
        do {
          guard let fetchedMovie = try self._context.fetch(fetchRequest) as? [CDMovieFavorite] else { return }
          completion(.success( fetchedMovie))
        } catch let error {
          completion(.failure(APIServiceError.custom(error)))
        }
      }
    }
    .subscribe(on: DispatchQueue.global(qos: .background))
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
}
