//
//  FavoriteListRequestTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 21/01/22.
//

import XCTest
@testable import MovieDB_VIP

final class FavoriteListRequestTests: XCTestCase {
  var sut: FavoriteListRequest!

  override func setUp() {
    super.setUp()
    sut = FavoriteListRequest()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_FavoritesListRequest_AccessFavModelNoPredicate() {
    XCTAssertEqual(sut.entityName, "CDMovieFavorite")
    XCTAssertEqual(sut.fetchLimit, 1)
    XCTAssertEqual(sut.predicate, nil)
  }
}
