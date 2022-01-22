//
//  MovieListRouter.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

import UIKit

final class MovieListRouter {
  
  private weak var rootVC: UIViewController?
  private var transitionDelegate: InteractiveModalTransitioningDelegate!

  init(view: UIViewController) {
      self.rootVC = view
  }
  
  func navigateToDetail(with model: MovieModel) {
    let detail = DetailModel(movieModel: model, review: [])
    let view = DetailView(detail: detail)
    let presenter = DetailPresenter(interface: view)
    let mapper = DetailMapper()
    let interactor = Injection.init().provideDetailUseCase(model: model, output: presenter, mapper: mapper)
    
    view.favSelection = { isFav, detail in
      isFav ? interactor.saveMovie(model: detail) : interactor.deleteMovie()
    }
    
    view.loadIsFav = interactor.isFavorited
    
    // MARK: - Invalid JSON Returned from Server
    /*
    The response returned by making request for list review to the following URL contained invalid JSON.
    The "content" field returned a string with backslash in the literal multiline string syntax
    I found out that it was not supposed to happen, since I passed the decoding using (non-blackslash) string in my unit test
    hence, I will comment the request code to not make it error.
     https://api.themoviedb.org/3/movie/{movie_id}/reviews?api_key=<<api_key>>&language=en-US&page=1
     */
    
//    view.loadItems = interactor.getReviews(source: .network)
    
    view.detail = detail // Temporary Measure
    
    rootVC?.show(view, sender: rootVC)
  }
  
  func navigateToFavorite() {
    let view = FavoriteListView()
    let router = self.makeFavoriteListRouter(from: view)
    let presenter = MovieListPresenter(interface: view)
    let mapper = FavoriteListMapper()
    let interactor = Injection.init().provideListUseCase(output: presenter, mapper: mapper)
    
    view.onSelection = router.navigateToDetail(with:)
    view.loadItems = interactor.getFavoriteLists
    
    rootVC?.show(view, sender: rootVC)
  }
  
  func navigateToCategory(lastCategory: Category) {
    guard let listVC = rootVC as? MovieListView else { return }
    let vc = CategoryPickerView()
    vc.selectedCategory = lastCategory
    vc.delegate = listVC
    vc.modalPresentationStyle = .custom
    self.transitionDelegate = InteractiveModalTransitioningDelegate(
      from: listVC,
      to: vc
  )
    
    vc.transitioningDelegate = transitionDelegate
    rootVC?.showDetailViewController(vc, sender: rootVC)
  }
  
  func makeFavoriteListRouter(from view: UIViewController) -> FavoriteListRouter {
    FavoriteListRouter(view: view)
  }
}
