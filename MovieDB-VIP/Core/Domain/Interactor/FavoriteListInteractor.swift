//
//  FavoriteListInteractor.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//

import Combine

protocol FavoriteListUseCase: AnyObject {
  func getFavoriteLists()
}

final class FavoriteListInteractor: BaseInteractor {
  private let _output: MovieListInteractorOutputProtocol
  private let _repository: FavoriteListRepositoryProtocol
  private let _mapper: (([MovieEntity]) -> [MovieModel])
  
  init(output: MovieListInteractorOutputProtocol, repository: FavoriteListRepositoryProtocol, mapper: @escaping (([MovieEntity]) -> [MovieModel])) {
    self._output = output
    self._repository = repository
    self._mapper = mapper
  }
}

extension FavoriteListInteractor: FavoriteListUseCase {
  func getFavoriteLists() {
    _output.stateUpdate(with: .loading)
    _repository.getAllFavorites()
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
