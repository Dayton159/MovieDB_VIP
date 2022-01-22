//
//  APIServiceError.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

enum APIServiceError: Error {
  case cannotMapToObject
  case noInternetConnection
  
  case custom(Error)
  
  var errorMessage: String {
    switch self {
    case .cannotMapToObject:
      return "Failed to Display data"
    case .noInternetConnection:
      return "Unable to Access Server. Please Check Your Network Connection"
    case .custom(let error):
      return error.localizedDescription.capitalized
    }
  }
}
