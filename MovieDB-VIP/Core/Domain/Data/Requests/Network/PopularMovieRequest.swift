//
//  PopularMovieRequest.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

struct PopularMovieRequest: APIRequest {
  typealias Response = MovieListResponses
  var pathname: String { "movie/popular" }
}
