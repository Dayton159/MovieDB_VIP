//
//  ReviewModel.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import Foundation

struct ReviewModel: Equatable {
  let author: String
  let avatar: ImageDownloader
  let rating: String
  let date: String
  
  internal init(author: String, avatar: String, rating: String, date: String) {
    self.author = author
    self.avatar = ImageDownloader(url: avatar, placeholder: Constants.Image.avatarPlaceholder)
    self.rating = rating
    self.date = date
  }
}
