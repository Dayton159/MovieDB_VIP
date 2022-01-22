//
//  MockListDataSource.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 19/01/22.
//

import Combine
@testable import MovieDB_VIP

class MockListDataSource: MovieListDataSourceProtocol {

  var expError: Error?

  func getPopularMovies() -> AnyPublisher<[MovieResponse], APIServiceError> {
    return self.makeResponse()
  }
  
  func getTopRatedMovies() -> AnyPublisher<[MovieResponse], APIServiceError> {
    return self.makeResponse()
  }
  
  func getNowPlayingMovies() -> AnyPublisher<[MovieResponse], APIServiceError> {
    return self.makeResponse()
  }
  
  private func makeResponse() -> AnyPublisher<[MovieResponse], APIServiceError> {
    return Future<[MovieResponse], APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(MovieResponse.dummy))
      }
    }
    .eraseToAnyPublisher()
  }
}
