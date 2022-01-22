//
//  URLSessionService.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

import Foundation
import Combine

class URLSessionService: APIService {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func fetch<ResponseType>(request: URLRequest,
                           decodeTo: ResponseType.Type) -> AnyPublisher<ResponseType, APIServiceError> where ResponseType: Decodable {
    return Future<ResponseType, APIServiceError> { completion in
      let datatask =  self.session.dataTask(with: request) { data, response, error in
        
        if let error = error {
          completion(.failure(APIServiceError.custom(error)))
          return
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode != 503 else {
          completion(.failure(APIServiceError.noInternetConnection))
          return
        }
        
        
        guard let data = data, !data.isEmpty else {
          completion(.failure(APIServiceError.cannotMapToObject))
          return
        }

        do {
          let model = try JSONDecoder().decode(ResponseType.self, from: data)
          completion(.success(model))
        } catch {
          completion(.failure(APIServiceError.cannotMapToObject))
        }
      }
      datatask.resume()
    }
    .subscribe(on: DispatchQueue.global(qos: .background))
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
}
