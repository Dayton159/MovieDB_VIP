//
//  MovieListPresenter.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

protocol MovieListViewProtocol: AnyObject {
  var movieLists: [MovieModel] { get set }
  func showError(by message: String)
  func state(_ state: NetworkState)
}

final class MovieListPresenter: MovieListInteractorOutputProtocol {
  weak private var view: MovieListViewProtocol?

  init(interface: MovieListViewProtocol) {
      self.view = interface
  }
  
  func didLoad(with movies: [MovieModel]) {
    self.view?.movieLists = movies
  }
  
  func stateUpdate(with state: NetworkState) {
    self.view?.state(state)
  }
  
  func didFail(with message: String) {
    self.view?.showError(by: message)
  }
}
