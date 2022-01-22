//
//  DetailView.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import UIKit

class DetailView: BaseView, DetailViewProtocol {
  @IBOutlet weak var tableView: UITableView!
  
  var detail: DetailModel {
    didSet {
      self.loadIsFav?()
      self.tableView.reloadData()
    }
  }
  
  var isFavorited: Bool = false {
    didSet {
      self.enableBarBtn(rightBtnItem)
      self.changeFavBtnState(isFav: isFavorited)
    }
  }

  var favSelection: ((Bool, DetailModel) -> Void)?
  var loadIsFav: (() -> Void)?
  var loadItems: (() -> Void)?
  
  init(detail: DetailModel) {
    self.detail = detail
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.configureNavBar(withTitle: "Detail Movie")
    self.configureRightBarButtonItem(with: Constants.Image.bookmark, type: .toogle)
    self.bindView()
    self.configureTableView()
    self.loadItems?()
  }
  
  func showError(by message: String) {
    Delay.wait {
      self.showError(message, delegate: self)
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
    self.rightBtnItem.addTarget(self, action: #selector(self.didTapRightBarBtn(_:)), for: .touchUpInside)
  }
  
  @objc func didTapRightBarBtn(_ sender: UIButton) {
    self.favSelection?(!isFavorited, detail)
  }
  
  func configureTableView() {
    self.tableView.registerReusableCell(DetailMovieTableViewCell.self)
    self.tableView.registerReusableCell(ReviewTableViewCell.self)
    self.tableView.tableFooterView = UIView()
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
    self.tableView.backgroundColor = .white
    self.tableView.separatorStyle = .none
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.tableView.dataSource = self
  }
}

extension DetailView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.detail.review.count + 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell: DetailMovieTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      let data = self.detail.movieModel
      cell.configureCell(data: data)
      return cell
    } else {
      let cell: ReviewTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      let data = self.detail.review[indexPath.row - 1]
      cell.configureCell(data: data)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      self.detail.movieModel.asyncPoster.cancelDownloading()
    } else {
      let data = self.detail.review[indexPath.row - 1]
      data.avatar.cancelDownloading()
    }
  }
}

extension DetailView: AlertPopUpPresentable, AlertDelegate {
  func didTapOkButton() {
    self.navigationController?.popViewController(animated: true)
  }
}

