//
//  BaseViewProtocol.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

enum NetworkState: Equatable {
  case loading
  case finish
  case error
}

extension NetworkState {
  var isFinished: Bool {
      guard case .finish = self else { return false }
      return true
  }
}

protocol BaseViewProtocol: AnyObject {
  func stateUpdate(with state: NetworkState)
  func didFail(with message: String)
}
