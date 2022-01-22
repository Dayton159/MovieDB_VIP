//
//  MovieListInteractorTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 20/01/22.
//

import XCTest
@testable import MovieDB_VIP

class MovieListInteractorTests: XCTestCase {
  
  var mockRepository: MockListRepository!
  var mockPresenter: MockMovieListPresenter!

  override func setUp() {
    super.setUp()
    mockRepository = MockListRepository()
    mockPresenter = MockMovieListPresenter()
  }
  
  override func tearDown() {
    mockRepository = nil
    mockPresenter = nil
    super.tearDown()
  }
  
  // MARK: -  Positive Case
  
  // Now Playing
  func test_FetchNowPlayingSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getNowPlayingMovies()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_FetchNowPlayingSuccess_ReturnModelArray() {
    let expResult = MovieModel.dummy
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getNowPlayingMovies()
    XCTAssertEqual(mockPresenter.movies, expResult)
  }
  
  func test_FetchNowPlayingSuccess_ErrorNil() {
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getNowPlayingMovies()
    XCTAssertNil(mockPresenter.message)
  }
  
  // Top Rated
  func test_FetchTopRatedSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getTopRatedMovies()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_FetchTopRatedSuccess_ReturnModelArray() {
    let expResult = MovieModel.dummy
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getTopRatedMovies()
    XCTAssertEqual(mockPresenter.movies, expResult)
  }
  
  func test_FetchTopRatedSuccess_ErrorNil() {
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getTopRatedMovies()
    XCTAssertNil(mockPresenter.message)
  }
  
  // Popular
  func test_FetchPopularSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getPopularMovies()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_FetchPopularSuccess_ReturnModelArray() {
    let expResult = MovieModel.dummy
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getPopularMovies()
    XCTAssertEqual(mockPresenter.movies, expResult)
  }
  
  func test_FetchPopularSuccess_ErrorNil() {
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getPopularMovies()
    XCTAssertNil(mockPresenter.message)
  }
  
  // MARK: -  Negative Case
  
  // Now Playing
  func test_FetchNowPlayingFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getNowPlayingMovies()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_FetchNowPlayingFailed_ModelArrayEmpty() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getNowPlayingMovies()
    XCTAssertTrue(mockPresenter.movies.isEmpty)
  }
  
  func test_FetchNowPlayingFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getNowPlayingMovies()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
  
  // Top Rated
  func test_FetchTopRatedFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getTopRatedMovies()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_FetchTopRatedFailed_ModelArrayEmpty() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getTopRatedMovies()
    XCTAssertTrue(mockPresenter.movies.isEmpty)
  }
  
  func test_FetchTopRatedFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getTopRatedMovies()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
  
  // Popular
  func test_FetchPopularFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getPopularMovies()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_FetchPopularFailed_ModelArrayEmpty() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getPopularMovies()
    XCTAssertTrue(mockPresenter.movies.isEmpty)
  }
  
  func test_FetchPopularFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideListUseCase(with: mockRepository, output: mockPresenter)
    
    sut.getPopularMovies()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
}
