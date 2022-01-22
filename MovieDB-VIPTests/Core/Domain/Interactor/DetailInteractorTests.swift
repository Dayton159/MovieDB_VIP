//
//  DetailInteractorTests.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//

import XCTest
@testable import MovieDB_VIP

class DetailInteractorTests: XCTestCase {
  
  var mockRepository: MockDetailRepository!
  var mockPresenter: MockDetailPresenter!

  override func setUp() {
    super.setUp()
    mockRepository = MockDetailRepository()
    mockPresenter = MockDetailPresenter()
  }
  
  override func tearDown() {
    mockRepository = nil
    mockPresenter = nil
    super.tearDown()
  }
  
  // MARK: - Positive Case
  
  // Review Remote
  func test_FetchReviewRemoteSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getReviews(source: .network)
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_FetchReviewRemoteSuccess_ReturnModel() {
    let expResult = DetailModel.dummy
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.getReviews(source: .network)
    XCTAssertEqual(mockPresenter.detail, expResult)
  }
  
  func test_FetchReviewRemoteSuccess_ErrorNil() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.getReviews(source: .network)
    XCTAssertNil(mockPresenter.message)
  }
  
  // Review Local
  func test_FetchReviewLocalSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyLocalFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getReviews(source: .local)
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_FetchReviewLocalSuccess_ReturnModel() {
    let expResult = DetailModel.dummyLocal
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyLocalFirst, with: mockRepository, output: mockPresenter)
    
    sut.getReviews(source: .local)
    XCTAssertEqual(mockPresenter.detail, expResult)
  }
  
  func test_FetchReviewLocalSuccess_ErrorNil() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyLocalFirst, with: mockRepository, output: mockPresenter)
    
    sut.getReviews(source: .local)
    XCTAssertNil(mockPresenter.message)
  }
  
  // Save Movie
  func test_SaveMovieSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.saveMovie(model: DetailModel.dummy)
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_SaveMovieSuccess_IsFavTrue() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.saveMovie(model: DetailModel.dummy)
    XCTAssertEqual(mockPresenter.isFav, true)
  }
  
  func test_SaveMovieSuccess_ErrorNil() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.saveMovie(model: DetailModel.dummy)
    XCTAssertNil(mockPresenter.message)
  }
  
  // Delete Movie
  func test_DeleteMovieSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.deleteMovie()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_DeleteMovieSuccess_IsFavFalse() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.deleteMovie()
    XCTAssertEqual(mockPresenter.isFav, false)
  }
  
  func test_DeleteMovieSuccess_ErrorNil() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.deleteMovie()
    XCTAssertNil(mockPresenter.message)
  }
  
  // Is Favorited Movie
  func test_IsFavMovieSuccess_LoadStateFinished() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.isFavorited()
    XCTAssertTrue(mockPresenter.state.isFinished)
  }
  
  func test_IsFavMovieSuccessWithTrue_IsFavTrue() {
    mockRepository.isFav = true
    
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.isFavorited()
    XCTAssertEqual(mockPresenter.isFav, true)
  }
  
  func test_IsFavMovieSuccessWithFalse_IsFavFalse() {
    mockRepository.isFav = false
    
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.isFavorited()
    XCTAssertEqual(mockPresenter.isFav, false)
  }
  
  func test_IsFavMovieSuccess_ErrorNil() {
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.isFavorited()
    XCTAssertNil(mockPresenter.message)
  }
  
  // MARK: - Negative Case
  
  // Review Remote
  func test_FetchReviewRemoteFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getReviews(source: .network)
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_FetchReviewRemoteFailed_ModelNil() {
    mockRepository.expError = MockError.none
   
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.getReviews(source: .network)
    XCTAssertNil(mockPresenter.detail)
  }
  
  func test_FetchReviewRemoteFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.getReviews(source: .network)
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
  
  // Review Local
  
  func test_FetchReviewLocalFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyLocalFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.getReviews(source: .local)
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_FetchReviewLocalFailed_ModelNil() {
    mockRepository.expError = MockError.none
   
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyLocalFirst, with: mockRepository, output: mockPresenter)
    
    sut.getReviews(source: .local)
    XCTAssertNil(mockPresenter.detail)
  }
  
  func test_FetchReviewLocalFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyLocalFirst, with: mockRepository, output: mockPresenter)
    
    sut.getReviews(source: .local)
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
  
  // Save Movie
  func test_SaveMovieFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.saveMovie(model: DetailModel.dummy)
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_SaveMovieFailed_IsFavNil() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.saveMovie(model: DetailModel.dummy)
    XCTAssertNil(mockPresenter.isFav)
  }
  
  func test_SaveMovieFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.saveMovie(model: DetailModel.dummy)
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
  
  // Delete Movie
  func test_DeleteMovieFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.deleteMovie()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_DeleteMovieFailed_IsFavNil() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.deleteMovie()
    XCTAssertNil(mockPresenter.isFav)
  }
  
  func test_DeleteMovieFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.deleteMovie()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
  
  // Is Favorited Movie
  func test_IsFavMovieFailed_LoadStateError() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    XCTAssertEqual(mockPresenter.state, .loading, "Precondition")
    sut.isFavorited()
    XCTAssertFalse(mockPresenter.state.isFinished)
  }
  
  func test_IsFavMovieFailed_IsFavNil() {
    mockRepository.expError = MockError.none
    
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.isFavorited()
    XCTAssertNil(mockPresenter.isFav)
  }
  
  func test_IsFavMovieFailed_ReturnErrorMessage() {
    mockRepository.expError = MockError.none
    
    let expMessage = APIServiceError.custom(MockError.none).errorMessage
    let sut = MockDI.init().provideDetailUseCase(model: MovieModel.dummyFirst, with: mockRepository, output: mockPresenter)
    
    sut.isFavorited()
    XCTAssertEqual(mockPresenter.message, expMessage)
  }
}
