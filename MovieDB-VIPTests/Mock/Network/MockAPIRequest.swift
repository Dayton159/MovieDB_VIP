//
//  MockAPIRequest.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 19/01/22.
//

@testable import MovieDB_VIP

struct MockAPIRequest: APIRequest {
  typealias Response = MockResponse
  
  var pathname: String { "mock/path/name" }
}
