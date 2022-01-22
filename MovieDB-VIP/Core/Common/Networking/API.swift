//
//  API.swift
//  MovieDB-VIP
//
//  Created by Dayton on 18/01/22.
//

import Foundation
import Combine

protocol APIService {
  func fetch<ResponseType: Decodable>(request: URLRequest,
                                      decodeTo: ResponseType.Type) -> AnyPublisher<ResponseType, APIServiceError>
}

class API<Request: APIRequest> {
  private let apiService: APIService

  init(apiService: APIService = URLSessionService()) {
    self.apiService = apiService
  }

  func fetch(_ request: Request) -> AnyPublisher<Request.Response, APIServiceError> {
    let urlRequest = request.makeURLRequest()
    return self.apiService.fetch(request: urlRequest, decodeTo: Request.Response.self)
  }
}

