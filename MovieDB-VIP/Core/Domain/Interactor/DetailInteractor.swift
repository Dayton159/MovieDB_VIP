//
//  DetailInteractor.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import Combine

protocol DetailInteractorOutputProtocol: BaseViewProtocol {
  func didLoad(with detail: DetailModel)
  func isFavorite(isFav: Bool)
}

protocol DetailUseCase: AnyObject {
  func getReviews(source: DataRequestSource)
  func saveMovie(model: DetailModel)
  func deleteMovie()
  func isFavorited()
}

final class DetailInteractor: BaseInteractor {
  private let _output: DetailInteractorOutputProtocol
  private let _repository: DetailRepositoryProtocol
  private let _mapper: (([ReviewEntity]) -> [ReviewModel])
  private let _saveMapper: ((DetailModel) -> DetailEntity)
  private let _model: MovieModel
  
  init(
    output: DetailInteractorOutputProtocol,
    repository: DetailRepositoryProtocol,
    mapper: @escaping (([ReviewEntity]) -> [ReviewModel]),
    saveMapper: @escaping ((DetailModel) -> DetailEntity),
    model: MovieModel) {
    self._output = output
    self._repository = repository
    self._mapper = mapper
    self._saveMapper = saveMapper
    self._model = model
  }
}

extension DetailInteractor: DetailUseCase {
  func getReviews(source: DataRequestSource) {
    _output.stateUpdate(with: .loading)
    _repository.getMovieReviews(source: source)
      .map { self._mapper($0) }
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.stateUpdate(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        let detail = DetailModel(movieModel: self._model, review: result)
        self._output.didLoad(with: detail)
        self._output.stateUpdate(with: .finish)
      })
      .store(in: &cancellables)
  }
  
  func saveMovie(model: DetailModel) {
    let movie = self._saveMapper(model)
    
    _output.stateUpdate(with: .loading)
    _repository.saveMovie(movie: movie)
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.stateUpdate(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.isFavorite(isFav: true)
        self._output.stateUpdate(with: .finish)
      })
      .store(in: &cancellables)
  }
  
  func deleteMovie() {
    _output.stateUpdate(with: .loading)
    _repository.deleteFavoriteMovie()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.stateUpdate(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.isFavorite(isFav: false)
        self._output.stateUpdate(with: .finish)
      })
      .store(in: &cancellables)
  }
  
  func isFavorited() {
    _output.stateUpdate(with: .loading)
    _repository.isMovieFavorited()
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.stateUpdate(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.isFavorite(isFav:result)
        self._output.stateUpdate(with: .finish)
      })
      .store(in: &cancellables)
  }
}
