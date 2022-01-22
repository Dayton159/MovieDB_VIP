//
//  APIConfiguration.swift
//  MovieDB-VIP
//
//  Created by Dayton on 18/01/22.
//

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

enum HTTPHeaderField{
  case contentType(String)
  
  var header: HTTPHeader {
    switch self {
    case .contentType(let value): return HTTPHeader(name: "Content-Type", value: value)
    }
  }
}

struct HTTPHeader {
  let name: String
  let value: String
}
