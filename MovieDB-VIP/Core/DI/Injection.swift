//
//  Injection.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

import Foundation

final class Injection: NSObject {
  
  // MARK: - Dependency Lists
  
  private func provideListRepository(mapper: @escaping (([MovieResponse]) -> [MovieEntity])) -> MovieListRepositoryProtocol {
    let popular = PopularMovieRequest()
    let nowPlaying = NowPlayingMovieRequest()
    let topRated = TopRatedMovieRequest()
    
    let dataSource = MovieListDataSource(popular, topRated, nowPlaying)
    return MovieListRepository(dataSource: dataSource, mapper: mapper)
  }
  
  private func provideListRepository(mapper: @escaping (([CDMovieFavorite]) -> [MovieEntity])) -> FavoriteListRepositoryProtocol {
    let favorite = FavoriteListRequest()
    let context = CoreDataStack.shared.context()
    
    let dataSource = FavoriteListDataSource(context: context, request: favorite)
    return FavoriteListRepository(dataSource: dataSource, mapper: mapper)
  }
  
  private func provideDetailRepository(
    id: Int,
    mapperRemote: @escaping (([ReviewResponse]) -> [ReviewEntity]),
    mapperLocal: @escaping (([CDReview]) -> [ReviewEntity])) -> DetailRepositoryProtocol {
      
    let reviewRemote = ReviewMovieRequest(movieID: id)
    let remote = DetailDataSource(reviewRemote)
    
    let save = SaveMovieRequest()
    let delete = DeleteMovieRequest(id: id)
    let isFav = IsFavoritedRequest(id: id)
    let reviewLocal = ReviewLocalRequest(id: id)
    
    let context = CoreDataStack.shared.context()
    
    let local = DetailFavDataSource(save: save, delete: delete, isFav: isFav, review: reviewLocal, context: context)
    
    return DetailRepository(remote: remote, local: local, mapperRemote: mapperRemote, mapperLocal: mapperLocal)
  }
  
  // MARK: - Use Cases
  
  func provideListUseCase(output: MovieListInteractorOutputProtocol, mapper: MovieListMapper) -> MovieListUseCase {
    let repository =  self.provideListRepository(mapper: mapper.transformResponseToEntity(response:))
    
    return MovieListInteractor(output: output, repository: repository, mapper: mapper.transformEntityToDomain(entity:))
  }
  
  func provideListUseCase(output: MovieListInteractorOutputProtocol, mapper: FavoriteListMapper) -> FavoriteListUseCase {
    let repository = self.provideListRepository(mapper: mapper.transformResponseToEntity(response:))
    
    return FavoriteListInteractor(output: output, repository: repository, mapper: mapper.transformEntityToDomain(entity:))
  }
  
  func provideDetailUseCase(model: MovieModel, output: DetailInteractorOutputProtocol, mapper: DetailMapper) -> DetailUseCase {
    let repository = self.provideDetailRepository(id: model.idMovie, mapperRemote: mapper.transformResponseToEntity(response:), mapperLocal: mapper.transformResponseToEntity(response:))
    
    return DetailInteractor(output: output, repository: repository, mapper: mapper.transformEntityToDomain(entity:), saveMapper: mapper.transformDetailDomainToEntity(detail:), model: model)
  }
}
