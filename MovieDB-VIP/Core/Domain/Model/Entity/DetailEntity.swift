//
//  File.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

struct DetailEntity: Equatable {
  let movie: MovieEntity
  let review: [CDReview]
}
