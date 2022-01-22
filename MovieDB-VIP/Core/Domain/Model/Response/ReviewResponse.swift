//
//  ReviewResponse.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//

struct ReviewListResponses: Codable, Equatable {
  let results: [ReviewResponse]
}

struct ReviewResponse: Codable, Equatable {
  let author: String?
  let detail: Author?
  let date: String?
  
  private enum CodingKeys: String, CodingKey {
    case author
    case detail = "author_details"
    case date = "created_at"
  } 
}

struct Author: Codable, Equatable {
  let avatar: String?
  let rating: Double?
  
  private enum CodingKeys: String, CodingKey {
    case rating
    case avatar = "avatar_path"
  }
}
