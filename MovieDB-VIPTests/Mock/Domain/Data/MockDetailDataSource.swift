//
//  MockDetailDataSource.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

import Combine
@testable import MovieDB_VIP

class MockDetailDataSource: DetailDataSourceProtocol {

  
  var expError: Error?
  
  func getMovieReviews() -> AnyPublisher<[ReviewResponse], APIServiceError> {
    return Future<[ReviewResponse], APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(ReviewResponse.dummy))
      }
    }
    .eraseToAnyPublisher()
  }
}
