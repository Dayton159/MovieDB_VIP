//
//  URLRequest+Extension.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

import Foundation

extension URLRequest {
  var method: HTTPMethod? {
    get {
      guard let httpMethodStr = self.httpMethod else { return nil }
      return HTTPMethod(rawValue: httpMethodStr)
    }
    set { self.httpMethod = newValue?.rawValue }
  }
  
  mutating func setHeader(_ field: HTTPHeaderField) {
    self.setValue(field.header.value, forHTTPHeaderField: field.header.name)
  }
}
