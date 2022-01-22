//
//  SaveMovieRequestTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

import XCTest
@testable import MovieDB_VIP

class SaveMovieRequestTests: XCTestCase {
  var sut: SaveMovieRequest!

  override func setUp() {
    super.setUp()
    sut = SaveMovieRequest()
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
