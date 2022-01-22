//
//  DeleteMovieRequestTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

import XCTest
@testable import MovieDB_VIP

class DeleteMovieRequestTests: XCTestCase {
  var sut: DeleteMovieRequest!

  override func setUp() {
    super.setUp()
    sut = DeleteMovieRequest(id: 12)
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_FavoritesListRequest_AccessFavModelWithPredicate() {
    XCTAssertEqual(sut.entityName, "CDMovieFavorite")
    XCTAssertEqual(sut.fetchLimit, 1)
    XCTAssertEqual(sut.predicate, NSPredicate(format: "idMovie == 12"))
  }
}
