//
//  ReviewMovieRequest.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//


struct ReviewMovieRequest: APIRequest {
  typealias Response = ReviewListResponses
  var movieID: Int
  var pathname: String { "movie/\(movieID)/reviews" }
}
