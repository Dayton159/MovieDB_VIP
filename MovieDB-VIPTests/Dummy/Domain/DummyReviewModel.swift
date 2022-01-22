//
//  DummyReviewModel.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

@testable import MovieDB_VIP

extension ReviewModel {
  static var dummy: [ReviewModel] {
    .init(
    [
      .init(
        author: "JPV852",
        avatar: "/xNLOqXXVJf9m7WngUMLIMFsjKgh.jpg",
        rating: "9.0",
        date: "23 Oct 2019"
      ),
      .init(
        author: "Andres Gomez",
        avatar: "/https://secure.gravatar.com/avatar/03a53cd53b8254fe582d4fe1acc26c4e.jpg",
        rating: "8.0",
        date: "24 Apr 2014"
      ),
      .init(
        author: "r96sk",
        avatar: "/https://secure.gravatar.com/avatar/96c2e0e4ac98450f9e8e3c0a0a40aad8.jpg",
        rating: "7.0",
        date: "16 Nov 2021"
      )
    ]
    )
  }
  
  static var dummyLocal: [ReviewModel] {
    .init(
    [
      .init(
        author: "r96sk",
        avatar: "/https://secure.gravatar.com/avatar/96c2e0e4ac98450f9e8e3c0a0a40aad8.jpg",
        rating: "7.0",
        date: "16 Nov 2021"
      ),
      .init(
        author: "Andres Gomez",
        avatar: "/https://secure.gravatar.com/avatar/03a53cd53b8254fe582d4fe1acc26c4e.jpg",
        rating: "8.0",
        date: "24 Apr 2014"
      ),
      .init(
        author: "JPV852",
        avatar: "/xNLOqXXVJf9m7WngUMLIMFsjKgh.jpg",
        rating: "9.0",
        date: "23 Oct 2019"
      )
    ]
    )
  }
}
