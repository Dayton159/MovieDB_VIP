//
//  DummyReviewResponse.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

@testable import MovieDB_VIP

extension ReviewResponse {
  static var dummy: [ReviewResponse] {
    .init(
    [
      .init(
        author: "JPV852",
        detail: Author(avatar: "/xNLOqXXVJf9m7WngUMLIMFsjKgh.jpg", rating: 9.0),
        date: "2019-10-23T22:36:59.798Z"
      ),
      .init(
        author: "Andres Gomez",
        detail: Author(avatar: "/https://secure.gravatar.com/avatar/03a53cd53b8254fe582d4fe1acc26c4e.jpg", rating: 8.0),
        date: "2014-04-24T00:11:47.766Z"
      ),
      .init(
        author: "r96sk",
        detail: Author(avatar: "/https://secure.gravatar.com/avatar/96c2e0e4ac98450f9e8e3c0a0a40aad8.jpg", rating: 7.0),
        date: "2021-11-16T13:30:37.745Z"
      )
    ]
    )
  }
}

