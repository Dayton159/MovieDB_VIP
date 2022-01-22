//
//  MovieListView.swift
//  MovieDB-VIP
//
//  Created by Dayton on 18/01/22.
//

import UIKit

enum Category: String, CaseIterable {
  case popular = "Popular"
  case topRated = "Top Rated"
  case nowPlaying = "Now Playing"
}

class MovieListView: BaseView, MovieListViewProtocol, AlertPopUpPresentable {
  @IBOutlet weak var tableView: UITableView!
  
  var movieLists: [MovieModel] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }

  var onSelection: ((MovieModel) -> Void)?
  var navCategorySelection: ((Category) -> Void)?
  var navFavSelection: (() -> Void)?
  var loadItems: ((Category) -> Void)?
  private var lastCategory: Category = .popular

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.configureNavBar(withTitle: "MovieDB")
    self.configureLeftBarButtonItem(with: Constants.Image.category)
    self.configureRightBarButtonItem(with: Constants.Image.fav)
    self.bindView()
    self.configureTableView()
    loadItems?(lastCategory)
  }

  func showError(by message: String) {
    Delay.wait {
      self.showError(message)
    }
  }
  
  func state(_ state: NetworkState) {
    switch state {
    case .loading:
      self.showLoader()
    default:
      self.hideLoader()
    }
  }
  
  func bindView() {
    self.leftBtnItem.addTarget(self, action: #selector(self.didTapLeftBarBtn(_:)), for: .touchUpInside)
    self.rightBtnItem.addTarget(self, action: #selector(self.didTapRightBarBtn(_:)), for: .touchUpInside)
  }
  
  func configureTableView() {
    self.tableView.registerReusableCell(MovieListTableViewCell.self)
    self.tableView.tableFooterView = UIView()
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
    self.tableView.backgroundColor = .white
    self.tableView.separatorStyle = .none
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  @objc func didTapLeftBarBtn(_ sender: UIButton) {
    self.navCategorySelection?(lastCategory)
  }
  
  @objc func didTapRightBarBtn(_ sender: UIButton) {
    self.navFavSelection?()
  }
}

extension MovieListView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.movieLists.count == 0 {
      tableView.setEmptyView(
       title: "Movie Data Empty",
       detail: "Oops! Seems like there is nothing to be found.",
       titleBtn: "Refresh",
       delegate: self
      )
    } else {
      tableView.restore()
    }
    return self.movieLists.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: MovieListTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    let data = movieLists[indexPath.row]
    cell.configureCell(data: data)
    
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selected = movieLists[indexPath.row]
    self.onSelection?(selected)
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      let data = movieLists[indexPath.row]
      data.asyncImage.cancelDownloading()
  }
}

extension MovieListView: EmptyViewDelegate, CategoryPickerDelegate {
  func didSelectCategory(_ category: Category) {
    self.lastCategory = category
    self.loadItems?(category)
  }

  func didTapButtonAction() {
    self.loadItems?(lastCategory)
  }
}
