//
//  FavoriteListRepositoryTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 21/01/22.
//

import XCTest
import Combine
import CoreData
@testable import MovieDB_VIP


class FavoriteListRepositoryTests: XCTestCase {

  var context: NSManagedObjectContext!
  var mockDataSource: MockFavoriteListDataSource!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    context = MockCoreDataStack().context()
    mockDataSource = MockFavoriteListDataSource(context: context)
    cancellables = []
  }
  
  override func tearDown() {
    context = nil
    mockDataSource = nil
    cancellables = nil
    super.tearDown()
  }
  
  func test_FetchFavoriteListSuccess_ReturnEntityArray() {
    let expResult = MovieEntity.dummyLocal
    
    let expectation = expectation(description: "Success Map to Entity Favorite Movie")
    let sut = MockDI.init().provideFavListRepository(with: mockDataSource)
    
    sut.getAllFavorites()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with \(expResult), got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { result in
        XCTAssertEqual(result, expResult, "Fetch Success Data \(result) Did not match expected value \(expResult)")
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchFavoriteListFailed_ReturnError() {
    mockDataSource.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    let expectation = expectation(description: "Failed Map to Entity Favorite Movie")
    let sut = MockDI.init().provideFavListRepository(with: mockDataSource)
    
    sut.getAllFavorites()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, expResult.errorMessage)
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to failed with \(expResult), got value \(result) instead")
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
}
