//
//  MockListRepository.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 20/01/22.
//

import Combine
@testable import MovieDB_VIP

class MockListRepository: MovieListRepositoryProtocol {
  
  var expError: Error?
  
  func getPopularMovies() -> AnyPublisher<[MovieEntity], APIServiceError> {
   return self.makeEntity()
  }
  
  func getTopRatedMovies() -> AnyPublisher<[MovieEntity], APIServiceError> {
    return self.makeEntity()
  }
  
  func getNowPlayingMovies() -> AnyPublisher<[MovieEntity], APIServiceError> {
    return self.makeEntity()
  }
  
  private func makeEntity() -> AnyPublisher<[MovieEntity], APIServiceError> {
    return Future<[MovieEntity], APIServiceError> { completion in
      if let expError = self.expError {
        completion(.failure(APIServiceError.custom(expError)))
      } else {
        completion(.success(MovieEntity.dummy))
      }
    }
    .eraseToAnyPublisher()
  }
}
