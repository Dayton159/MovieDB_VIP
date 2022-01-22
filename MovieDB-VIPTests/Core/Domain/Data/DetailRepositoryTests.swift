//
//  DetailRepositoryTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

import XCTest
import Combine
@testable import MovieDB_VIP

class DetailRepositoryTests: XCTestCase {
  var mockRemote: MockDetailDataSource!
  var mockLocal: MockDetailFavDataSource!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    mockRemote = MockDetailDataSource()
    mockLocal = MockDetailFavDataSource()
    cancellables = []
  }
  
  override func tearDown() {
    mockRemote = nil
    mockLocal = nil
    cancellables = nil
    super.tearDown()
  }
  
  // MARK: - Positive Case
  
  func test_FetchReviewRemoteSuccess_ReturnEntity() {
    let expResult = ReviewEntity.dummy
    let expectation = expectation(description: "Success Map to Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    sut.getMovieReviews(source: .network)
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
  
  func test_FetchReviewLocalSuccess_ReturnEntity() {
    let expResult = ReviewEntity.dummyLocal
    let expectation = expectation(description: "Success Map to Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    sut.getMovieReviews(source: .local)
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
  
  func test_DeleteReviewSuccess_ReturnVoid() {
    let expectation = expectation(description: "Success Delete to Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    sut.deleteFavoriteMovie()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with , got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { _ in
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_SaveReviewSuccess_ReturnVoid() {
    let expectation = expectation(description: "Success Save  Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    let dummy = DetailEntity(movie: MovieEntity(idMovie: 0, title: "", overview: "", releaseDate: nil, backdropPath: "", posterPath: ""), review: [])
    
    sut.saveMovie(movie: dummy)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with , got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { _ in
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_isFavoriteTrue_ReturnTrue() {
    mockLocal.isFav = true
    
    let expectation = expectation(description: "Is Fav  Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    sut.isMovieFavorited()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with , got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { result in
        XCTAssertTrue(result)
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func test_isFavoriteFalse_ReturnFalse() {
    
    let expectation = expectation(description: "Is Fav  Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    sut.isMovieFavorited()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          XCTFail("Expected to success with , got error \(error) instead")
        case .finished: break
        }
      }, receiveValue: { result in
        XCTAssertFalse(result)
        expectation.fulfill()
      })
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  // MARK: -  Negative Case
  
  func test_FetchReviewRemoteFailed_ReturnError() {
    mockRemote.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    let expectation = expectation(description: "Failed Map to Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    sut.getMovieReviews(source: .network)
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
  
  func test_FetchReviewLocalFailed_ReturnError() {
    mockLocal.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    let expectation = expectation(description: "Failed Map to Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    sut.getMovieReviews(source: .local)
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
  
  func test_DeleteReviewFailed_ReturnError() {
    mockLocal.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    let expectation = expectation(description: "Failed Delete Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    sut.deleteFavoriteMovie()
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
  
  func test_SaveReviewFailed_ReturnErorr() {
    mockLocal.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    let expectation = expectation(description: "Failed Save Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    let dummy = DetailEntity(movie: MovieEntity(idMovie: 0, title: "", overview: "", releaseDate: nil, backdropPath: "", posterPath: ""), review: [])
    
    sut.saveMovie(movie: dummy)
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
  
  func test_isFavoriteFailed_ReturnError() {
    mockLocal.expError = MockError.none
    let expResult = APIServiceError.custom(MockError.none)
    let expectation = expectation(description: "Is Fav  Review Movie")
    let sut = MockDI.init().provideDetailRepository(remote: mockRemote, locaL: mockLocal)
    
    sut.isMovieFavorited()
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
