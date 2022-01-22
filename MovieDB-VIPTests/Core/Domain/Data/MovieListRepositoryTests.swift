//
//  MovieListRepositoryTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 19/01/22.
//

import XCTest
import Combine
@testable import MovieDB_VIP

class MovieListRepositoryTests: XCTestCase {

  var mockDataSource: MockListDataSource!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    mockDataSource = MockListDataSource()
    cancellables = []
  }
  
  override func tearDown() {
    mockDataSource = nil
    cancellables = nil
    super.tearDown()
  }
  
  func test_FetchNowPlayingSuccess_ReturnEntityArray() {
    let expResult = MovieEntity.dummy
    let expectation = expectation(description: "Success Map to Entity Now Playing Movie")
    let sut = MockDI.init().provideListRepository(with: mockDataSource)
    
    sut.getNowPlayingMovies()
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

  func test_FetchTopRatedSuccess_ReturnEntityArray() {
    let expResult = MovieEntity.dummy
    let expectation = expectation(description: "Success Map to Entity Top Rated Movie")
    let sut = MockDI.init().provideListRepository(with: mockDataSource)
    
    sut.getTopRatedMovies()
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
  
  func test_FetchPopularSuccess_ReturnEntityArray() {
    let expResult = MovieEntity.dummy
    let expectation = expectation(description: "Success Map to Entity Top Rated Movie")
    let sut = MockDI.init().provideListRepository(with: mockDataSource)
    
    sut.getPopularMovies()
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
  
  // MARK: - Negative Case
  
  func test_FetchNowPlayingFailed_ReturnError() {
    mockDataSource.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    let expectation = expectation(description: "Failed Map to Entity Now Playing Movie")
    let sut = MockDI.init().provideListRepository(with: mockDataSource)
    
    sut.getNowPlayingMovies()
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
  
  func test_FetchTopRatedFailed_ReturnError() {
    mockDataSource.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    let expectation = expectation(description: "Failed Map to Entity Top Rated Movie")
    let sut = MockDI.init().provideListRepository(with: mockDataSource)
    
    sut.getTopRatedMovies()
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
  
  func test_FetchPopularFailed_ReturnError() {
    mockDataSource.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    let expectation = expectation(description: "Failed Map to Entity Popular Movie")
    let sut = MockDI.init().provideListRepository(with: mockDataSource)
    
    sut.getPopularMovies()
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
