//
//  AppRouter.swift
//  MovieDB-VIP
//
//  Created by Dayton on 20/01/22.
//

import UIKit

class AppRouter {
  func makeMainView() -> UIViewController {
    let view = MovieListView()
    let router = self.makelistRouter(from: view)
    let presenter = MovieListPresenter(interface: view)
    let mapper = MovieListMapper()
    let interactor = Injection.init().provideListUseCase(output: presenter, mapper: mapper)
    
    view.onSelection = router.navigateToDetail(with:)
    view.navFavSelection = router.navigateToFavorite
    view.navCategorySelection = router.navigateToCategory
    view.loadItems = { category in
      switch category {
      case .popular: interactor.getPopularMovies()
      case .nowPlaying: interactor.getNowPlayingMovies()
      case .topRated: interactor.getTopRatedMovies()
      }
    }
    
    return UINavigationController(rootViewController: view)
  }
  
  func makelistRouter(from view: UIViewController) -> MovieListRouter {
    MovieListRouter(view: view)
  }
}
