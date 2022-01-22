//
//  FavoriteListView.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//

import UIKit

class FavoriteListView: BaseView, MovieListViewProtocol, AlertPopUpPresentable {
  @IBOutlet weak var tableView: UITableView!
  
  var movieLists: [MovieModel] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  var onSelection: ((MovieModel) -> Void)?
  var loadItems: (() -> Void)?
 
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.configureNavBar(withTitle: "Favorite Movie")
    self.configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.loadItems?()
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
}

extension FavoriteListView: UITableViewDelegate, UITableViewDataSource {
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
      guard movieLists.count < indexPath.row else { return }
      let data = movieLists[indexPath.row]
      data.asyncImage.cancelDownloading()
  }
}

extension FavoriteListView: EmptyViewDelegate {
  func didTapButtonAction() {
    self.loadItems?()
  }
}
