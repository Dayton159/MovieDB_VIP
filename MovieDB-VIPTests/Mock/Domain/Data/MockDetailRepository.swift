//
//  MockDetailRepository.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

import Combine
@testable import MovieDB_VIP

class MockDetailRepository: DetailRepositoryProtocol {
  
  var expError: Error?
  var isFav: Bool = false
  
  func getMovieReviews(source: DataRequestSource) -> AnyPublisher<[ReviewEntity], APIServiceError> {
    return Future<[ReviewEntity], APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        switch source {
        case .network:
          completion(.success(ReviewEntity.dummy))
        case .local:
          completion(.success(ReviewEntity.dummyLocal))
        }
      }
    }
    .eraseToAnyPublisher()
  }
  
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
