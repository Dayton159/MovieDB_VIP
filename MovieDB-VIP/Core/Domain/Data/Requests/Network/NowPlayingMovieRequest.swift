//
//  NowPlayingMovieRequest.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

struct NowPlayingMovieRequest: APIRequest {
  typealias Response = MovieListResponses
  var pathname: String { "movie/now_playing" }
}
