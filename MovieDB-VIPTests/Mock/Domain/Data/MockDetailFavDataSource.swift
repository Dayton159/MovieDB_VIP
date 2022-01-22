//
//  MockDetailFavDataSource.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

import Combine
@testable import MovieDB_VIP

class MockDetailFavDataSource: DetailFavDataSourceProtocol {
  var expError: Error?
  var isFav: Bool = false
  
  func saveMovie(movie: DetailEntity) -> AnyPublisher<Void, APIServiceError> {
    return Future<Void, APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(()))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func getMovieReviews() -> AnyPublisher<[CDReview], APIServiceError> {
    return Future<[CDReview], APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(CDReview.dummyLocal))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func deleteFavoriteMovie() -> AnyPublisher<Void, APIServiceError> {
    return Future<Void, APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(()))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func isMovieFavorited() -> AnyPublisher<Bool, APIServiceError> {
    return Future<Bool, APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(self.isFav))
      }
    }
    .eraseToAnyPublisher()
  }
  
}
