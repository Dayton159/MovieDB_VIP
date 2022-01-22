//
//  MockDetailPresenter.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

@testable import MovieDB_VIP

class MockDetailPresenter: DetailInteractorOutputProtocol {
  
  var detail: DetailModel?
  var state: NetworkState = .loading
  var isFav: Bool?
  var message: String?
  
  func didLoad(with detail: DetailModel) {
    self.detail = detail
  }
  
  func isFavorite(isFav: Bool) {
    self.isFav = isFav
  }
  
  func stateUpdate(with state: NetworkState) {
    self.state = state
  }
  
  func didFail(with message: String) {
    self.message = message
  }
}
