//
//  TopRatedMovieRequest.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

struct TopRatedMovieRequest: APIRequest {
  typealias Response = MovieListResponses
  var pathname: String { "movie/top_rated" }
}
