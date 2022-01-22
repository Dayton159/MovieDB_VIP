//
//  MockMovieListPresenter.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 20/01/22.
//

@testable import MovieDB_VIP

class MockMovieListPresenter: MovieListInteractorOutputProtocol {
  
  var movies: [MovieModel] = []
  var state: NetworkState = .loading
  var message: String?
  
  func didLoad(with movies: [MovieModel]) {
    self.movies = movies
  }
  
  func stateUpdate(with state: NetworkState) {
    self.state = state
  }
  
  func didFail(with message: String) {
    self.message = message
  }
}
