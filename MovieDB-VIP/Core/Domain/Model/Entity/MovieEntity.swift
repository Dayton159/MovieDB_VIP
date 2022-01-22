//
//  MovieListEntity.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

import Foundation

struct MovieEntity: Equatable {
  let idMovie: Int64?
  let title: String?
  let overview: String?
  let releaseDate: Date?
  let backdropPath: String?
  let posterPath: String?
}
