//
//  PopularRequestTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 19/01/22.
//

import XCTest
import Combine
@testable import MovieDB_VIP

class PopularRequestTests: XCTestCase {
  
  var sut: MockAPIService!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    sut = MockAPIService()
    cancellables = []
  }
  
  override func tearDown() {
    sut = nil
    cancellables = nil
    super.tearDown()
  }
  
  func test_FetchPopularSuccessful_ReturnMovieResponse() {
    guard let expResult = try? JSONDecoder().decode(MovieListResponses.self, from: DummyMovieJSON.list.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    
    sut.dummyResponse = DummyMovieJSON.list
    sut.expMethod = "GET"
    sut.expPathname = "/3/movie/popular"
    sut.expQueryItemParam = "api_key"
    sut.expQueryItemString = Environment.apiKey
    
    let expectation = expectation(description: "Success Fetch Popular Movie")
    let request = PopularMovieRequest()
    
    API(apiService: sut)
      .fetch(request)
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
  
  func test_FetchPopularFailed_ReturnError() {
    let expResult = APIServiceError.custom(MockError.none)
    
    sut.dummyResponse = DummyMovieJSON.list
    sut.expMethod = "GET"
    sut.expPathname = "/3/movie/popular"
    sut.expQueryItemParam = "api_key"
    sut.expQueryItemString = Environment.apiKey
    sut.expError = MockError.none
    
    let expectation = expectation(description: "Failed Fetch Popular Movie")
    let request = PopularMovieRequest()
    
    API(apiService: sut)
      .fetch(request)
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
