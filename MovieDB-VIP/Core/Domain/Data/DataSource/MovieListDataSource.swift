//
//  MovieListDataSource.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

import Combine

protocol MovieListDataSourceProtocol: AnyObject {
  func getPopularMovies() -> AnyPublisher<[MovieResponse], APIServiceError>
  func getTopRatedMovies() -> AnyPublisher<[MovieResponse], APIServiceError>
  func getNowPlayingMovies() -> AnyPublisher<[MovieResponse], APIServiceError>
}

final class MovieListDataSource {
  private let _popular: PopularMovieRequest
  private let _topRated: TopRatedMovieRequest
  private let _nowPlaying: NowPlayingMovieRequest
  
  init(_ popular: PopularMovieRequest,_ topRated: TopRatedMovieRequest,_  nowPlaying: NowPlayingMovieRequest) {
    self._popular = popular
    self._topRated = topRated
    self._nowPlaying = nowPlaying
  }
}

extension MovieListDataSource: MovieListDataSourceProtocol {
  func getPopularMovies() -> AnyPublisher<[MovieResponse], APIServiceError> {
    return API()
      .fetch(_popular)
      .map { $0.results }
      .eraseToAnyPublisher()
  }
  
  func getTopRatedMovies() -> AnyPublisher<[MovieResponse], APIServiceError> {
    return API()
      .fetch(_topRated)
      .map { $0.results }
      .eraseToAnyPublisher()
  }
  
  func getNowPlayingMovies() -> AnyPublisher<[MovieResponse], APIServiceError> {
    return API()
      .fetch(_nowPlaying)
      .map { $0.results }
      .eraseToAnyPublisher()
  }
}
