//
//  MockMovieResponse.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 19/01/22.
//

struct MockResponse: Codable, Equatable {
  let title: String
  let overview: String
  let idMovie: Int
  
  private enum CodingKeys: String, CodingKey {
    case overview, title
    case idMovie = "id"
  }
}
