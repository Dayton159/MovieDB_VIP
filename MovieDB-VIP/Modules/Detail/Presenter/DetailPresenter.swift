//
//  DetailPresenter.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

protocol DetailViewProtocol: AnyObject {
  var detail: DetailModel { get set }
  var isFavorited: Bool { get set }
  func showError(by message: String)
  func state(_ state: NetworkState)
}

final class DetailPresenter: DetailInteractorOutputProtocol {
  weak private var view: DetailViewProtocol?
  
  init(interface: DetailViewProtocol) {
      self.view = interface
  }
  
  func didLoad(with detail: DetailModel) {
    self.view?.detail = detail
  }
  
  func isFavorite(isFav: Bool) {
    self.view?.isFavorited = isFav
  }
  
  func stateUpdate(with state: NetworkState) {
    self.view?.state(state)
  }
  
  func didFail(with message: String) {
    self.view?.showError(by: message)
  }
}
