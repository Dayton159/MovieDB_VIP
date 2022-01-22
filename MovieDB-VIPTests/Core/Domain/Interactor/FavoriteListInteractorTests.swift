//
//  FavoriteListInteractorTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 21/01/22.
//

import XCTest
@testable import MovieDB_VIP

class FavoriteListInteractorTests: XCTestCase {

  var mockRepository: MockFavoriteListRepository!
  var mockPresenter: MockMovieListPresenter!

  override func setUp() {
    super.setUp()
    mockRepository = MockFavoriteListRepository()
    mockPresenter = MockMovieListPresenter()
  }
  
  override func tearDown() {
    mockRepository = nil
    mockPresenter = nil
    super.tearDown()
  }

  // MARK: - Positive Case
  
  func test_FetchFavoriteListSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getFavoriteLists()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_FetchFavoriteListSuccess_ReturnModelArray() {
    let expResult = MovieModel.dummyLocal
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getFavoriteLists()
    XCTAssertEqual(mockPresenter.movies, expResult)
  }
  
  func test_FetchFavoriteListSuccess_ErrorNil() {
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getFavoriteLists()
    XCTAssertNil(mockPresenter.message)
  }
  
  // MARK: - Negative Case
  
  func test_FetchFavoriteListFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getFavoriteLists()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_FetchFavoriteListFailed_ModelArrayEmpty() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getFavoriteLists()
    XCTAssertTrue(mockPresenter.movies.isEmpty)
  }
  
  func test_FetchFavoriteListFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getFavoriteLists()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
}
