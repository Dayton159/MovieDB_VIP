//
//  IsFavoritedRequest.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import Foundation

struct IsFavoritedRequest: CoreDataRequest {
  var id: Int
  var predicate: NSPredicate? {
    NSPredicate(format: "idMovie == \(id)")
  }
}
