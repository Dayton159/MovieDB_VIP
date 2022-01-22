//
//  MovieResponse.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

struct MovieListResponses: Codable, Equatable {
  let results: [MovieResponse]
}

struct MovieResponse: Codable, Equatable {
  let posterPath: String?
  let overview: String?
  let releaseDate: String?
  let idMovie: Int?
  let title: String?
  let backdropPath: String?
  
  private enum CodingKeys: String, CodingKey {
    case overview, title
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case idMovie = "id"
    case backdropPath = "backdrop_path"
  }
}
