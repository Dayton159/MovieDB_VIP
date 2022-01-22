//
//  IsFavoritedRequestTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

import XCTest
@testable import MovieDB_VIP

class IsFavoritedRequestTests: XCTestCase {
  var sut: IsFavoritedRequest!

  override func setUp() {
    super.setUp()
    sut = IsFavoritedRequest(id: 15)
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_FavoritesListRequest_AccessFavModelWithPredicate() {
    XCTAssertEqual(sut.entityName, "CDMovieFavorite")
    XCTAssertEqual(sut.fetchLimit, 1)
    XCTAssertEqual(sut.predicate, NSPredicate(format: "idMovie == 15"))
  }
}
