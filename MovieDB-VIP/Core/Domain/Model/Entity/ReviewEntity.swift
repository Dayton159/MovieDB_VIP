//
//  ReviewEntity.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import Foundation

struct ReviewEntity: Equatable {
  let author: String?
  let avatar: String?
  let rating: Double?
  let date: Date?
}
