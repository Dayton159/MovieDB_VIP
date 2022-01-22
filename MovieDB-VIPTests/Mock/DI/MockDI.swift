//
//  MockDI.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 19/01/22.
//

import Foundation
@testable import MovieDB_VIP

final class MockDI: NSObject {
  func provideListRepository(with dataSource: MovieListDataSourceProtocol) -> MovieListRepositoryProtocol {
    let mapper = MovieListMapper()
    
    return MovieListRepository(dataSource: dataSource, mapper: mapper.transformResponseToEntity(response:))
  }
  
  func provideFavListRepository(with dataSource: FavoriteListDataSourceProtocol) -> FavoriteListRepositoryProtocol {
    let mapper = FavoriteListMapper()
    return FavoriteListRepository(dataSource: dataSource, mapper: mapper.transformResponseToEntity(response:))
  }
  
  func provideDetailRepository(remote: DetailDataSourceProtocol, locaL: DetailFavDataSourceProtocol) -> DetailRepositoryProtocol {
    let mapper = DetailMapper()
    return DetailRepository(remote: remote, local: locaL, mapperRemote: mapper.transformResponseToEntity(response:), mapperLocal: mapper.transformResponseToEntity(response:))
  }
  
  func provideListUseCase(with repository: MovieListRepositoryProtocol, output: MovieListInteractorOutputProtocol) -> MovieListUseCase {
    let mapper = MovieListMapper()
    
    return MovieListInteractor(output: output, repository: repository, mapper: mapper.transformEntityToDomain(entity:))
  }
  
  func provideListUseCase(with repository: FavoriteListRepositoryProtocol, output: MovieListInteractorOutputProtocol) -> FavoriteListUseCase {
    let mapper = FavoriteListMapper()
    
    return FavoriteListInteractor(output: output, repository: repository, mapper: mapper.transformEntityToDomain(entity:))
  }
  
  func provideDetailUseCase(model: MovieModel, with repository: DetailRepositoryProtocol, output: DetailInteractorOutputProtocol) -> DetailUseCase {
    let mapper = DetailMapper()
    
    return DetailInteractor(output: output, repository: repository, mapper: mapper.transformEntityToDomain(entity:), saveMapper: mapper.transformDetailDomainToEntity(detail:), model: model)
  }
}
