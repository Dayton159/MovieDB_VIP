//
//  DetailDataSource.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import Combine

protocol DetailDataSourceProtocol: AnyObject {
  func getMovieReviews() -> AnyPublisher<[ReviewResponse], APIServiceError>
}

final class DetailDataSource {
  private let _review: ReviewMovieRequest
  
  init(_ review: ReviewMovieRequest) {
    self._review = review
  }
}

extension DetailDataSource: DetailDataSourceProtocol {
  func getMovieReviews() -> AnyPublisher<[ReviewResponse], APIServiceError> {
    return API()
      .fetch(_review)
      .map { $0.results }
      .eraseToAnyPublisher()
  }
}
