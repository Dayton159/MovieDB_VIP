//
//  MovieListInteractor.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

import Combine

protocol MovieListInteractorOutputProtocol: BaseViewProtocol  {
  func didLoad(with movies: [MovieModel])
}

protocol MovieListUseCase: AnyObject {
  func getPopularMovies()
  func getTopRatedMovies()
  func getNowPlayingMovies()
}

final class MovieListInteractor: BaseInteractor {
  private let _output: MovieListInteractorOutputProtocol
  private let _repository: MovieListRepositoryProtocol
  private let _mapper: (([MovieEntity]) -> [MovieModel])
  
  init(output: MovieListInteractorOutputProtocol, repository: MovieListRepositoryProtocol, mapper: @escaping (([MovieEntity]) -> [MovieModel])) {
    self._output = output
    self._repository = repository
    self._mapper = mapper
  }
}

extension MovieListInteractor: MovieListUseCase {
  func getPopularMovies() {
    _output.stateUpdate(with: .loading)
    _repository.getPopularMovies()
      .map { self._mapper($0) }
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.stateUpdate(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.didLoad(with: result)
        self._output.stateUpdate(with: .finish)
      })
      .store(in: &cancellables)
  }
  
  func getTopRatedMovies() {
    _output.stateUpdate(with: .loading)
    _repository.getTopRatedMovies()
      .map { self._mapper($0) }
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.stateUpdate(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.didLoad(with: result)
        self._output.stateUpdate(with: .finish)
      })
      .store(in: &cancellables)
  }
  
  func getNowPlayingMovies() {
    _output.stateUpdate(with: .loading)
    _repository.getNowPlayingMovies()
      .map { self._mapper($0) }
      .sink(receiveCompletion: { errorData in
        switch errorData {
        case .failure(let error):
          self._output.stateUpdate(with: .error)
          self._output.didFail(with: error.errorMessage)
        default: break
        }
      }, receiveValue: { result in
        self._output.didLoad(with: result)
        self._output.stateUpdate(with: .finish)
      })
      .store(in: &cancellables)
  }
}
