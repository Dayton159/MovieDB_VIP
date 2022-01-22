//
//  APINetworkTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 19/01/22.
//

import XCTest
import Combine
@testable import MovieDB_VIP

class APINetworkTests: XCTestCase {
  
  var sut: APIService!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    let config = URLSessionConfiguration.default
    config.protocolClasses = [MockURLProtocol.self]
    let urlSession = URLSession(configuration: config)
    sut = URLSessionService(session: urlSession)
    cancellables = []
  }
  
  override func tearDown() {
    sut = nil
    cancellables = nil
    MockURLProtocol.data = nil
    super.tearDown()
  }
  
  
  func test_FetchRequestSuccessfulWithResponse_ShouldReturnResponseModel() {
    let dummyResponse = """
{
  "title": "Example Movie title",
  "overview": "Example Movie overview",
  "id": 9999
}
"""
    MockURLProtocol.responseWithStatusCode(code: 200, data: dummyResponse.data(using: .utf8))
    
    guard let expResult = try? JSONDecoder().decode(MockResponse.self, from: dummyResponse.data(using: .utf8)!)
    else { XCTFail("Failed to decode Expected Response")
      return
    }
    
    let request = MockAPIRequest()
    let expectation = expectation(description: "Success Request With Response")
    
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
  
  func test_FetchRequestSuccessfulWithoutData_ShouldReturnMappingError() {
    MockURLProtocol.responseWithStatusCode(code: 204, data: nil)
    
    let request = MockAPIRequest()
    let expectation = expectation(description: "Success Request Without Data")
    
    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, APIServiceError.cannotMapToObject.errorMessage)
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchRequestFailedWithErrorResponse_ShouldReturnMappingError() {
    let dummyErrorResponse = """
{
    "success": false,
    "status_code": 34,
    "status_message": "The resource you requested could not be found."
}
"""
    
    MockURLProtocol.responseWithStatusCode(code: 404, data: dummyErrorResponse.data(using: .utf8))

    let request = MockAPIRequest()
    let expectation = expectation(description: "Failed Request With Response")

    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, APIServiceError.cannotMapToObject.errorMessage)
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchRequestFailedWithError_ShouldReturnCustomError() {
    MockURLProtocol.responseWithFailure()
    
    let request = MockAPIRequest()
    let expectation = expectation(description: "Failed Request With Error")
    
    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, APIServiceError.custom(MockError.none).errorMessage)
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_FetchRequestFailedWithoutConnection_ShouldReturnConnectionError() {
    MockURLProtocol.responseWithStatusCode(code: 503, data: nil)
    
    let request = MockAPIRequest()
    let expectation = expectation(description: "Failed Request Without Connection")
    
    API(apiService: sut)
      .fetch(request)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTAssertEqual(error.errorMessage, APIServiceError.noInternetConnection.errorMessage)
          expectation.fulfill()
        case .finished: break
        }
      }, receiveValue: { result in
        XCTFail("Expected to fail, got value \(result) instead")
      })
      .store(in: &cancellables)

    waitForExpectations(timeout: 2, handler: nil)
  }
}
