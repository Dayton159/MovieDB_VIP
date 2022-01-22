//
//  CDReview.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//

import Foundation

public class CDReview: NSObject {
  let author: String?
  let detail: CDAuthor?
  let date: Date?
  
  init(author: String?, detail: CDAuthor?, date: Date?) {
    self.author = author
    self.detail = detail
    self.date = date
  }
}

class CDAuthor: NSObject {
  let avatar: String?
  let rating: Double?
  
  init(avatar: String?, rating: Double?) {
    self.avatar = avatar
    self.rating = rating
  }
}
