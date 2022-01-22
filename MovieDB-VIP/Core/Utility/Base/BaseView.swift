//
//  BaseView.swift
//  MovieDB-VIP
//
//  Created by Dayton on 20/01/22.
//

import UIKit

enum BarButtonType {
  case toogle
  case defaultAction
}

class BaseView: UIViewController {
  
  lazy var leftBtnItem: UIButton = {
    let button = UIButton()
    return button
  }()
  
  lazy var rightBtnItem: UIButton = {
    let button = UIButton()
    return button
  }()
  
  private let activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
      activityIndicator.hidesWhenStopped = true
      return activityIndicator
  }()

  private let activityIndicatorBackgroundView: UIView = {
      let backgroundView = UIView()
      backgroundView.backgroundColor = .white
      return backgroundView
  }()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.activityIndicatorBackgroundView.addSubview(self.activityIndicator)
      self.view.addSubview(self.activityIndicatorBackgroundView)
      self.activityIndicatorBackgroundView.isHidden = true
  }

  override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      self.activityIndicatorBackgroundView.frame = self.view.bounds
  }
  
  func showLoader() {
      self.view.bringSubviewToFront(activityIndicatorBackgroundView)
      self.activityIndicator.center = self.activityIndicatorBackgroundView.center
      self.activityIndicatorBackgroundView.isHidden = false
      self.activityIndicator.startAnimating()
  }

  func hideLoader() {
      self.view.sendSubviewToBack(activityIndicatorBackgroundView)
      self.activityIndicatorBackgroundView.isHidden = true
      self.activityIndicator.stopAnimating()
  }
  
  func configureNavBar(withTitle title: String? = nil, prefersLargeTitles: Bool = false) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: Constants.Font.bold(36)]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: Constants.Font.bold(18)]
    appearance.backgroundColor = .systemBlue

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance

    navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
    navigationItem.title = title

    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true

    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    self.navigationController?.navigationBar.barStyle = .black
  }
}

extension BaseView {
  func configureRightBarButtonItem(with image: UIImage?, type: BarButtonType = .defaultAction) {
    let button = rightBtnItem
    let barItem = UIBarButtonItem(customView: button)
    self.setBarBtnImage(button,image)
    self.enableBarBtn(button, enable: type == .defaultAction)
    navigationItem.rightBarButtonItem = barItem
  }
  
  func configureLeftBarButtonItem(with image: UIImage?, type: BarButtonType = .defaultAction) {
    let button = leftBtnItem
    let barItem = UIBarButtonItem(customView: button)
    self.setBarBtnImage(button,image)
    self.enableBarBtn(button, enable: type == .defaultAction)
    navigationItem.leftBarButtonItem = barItem
  }
  
  func enableBarBtn(_ button: UIButton, enable: Bool = true) {
    button.isUserInteractionEnabled = enable
    button.isEnabled = enable
  }

  private func setBarBtnImage(_ button: UIButton, _ image: UIImage?) {
    button.setImage(image, for: .normal)
  }

  func changeFavBtnState(isRightBtn: Bool = true, isFav: Bool) {
    self.setBarBtnImage(isRightBtn ? rightBtnItem : leftBtnItem,
                        isFav ? Constants.Image.bookmarkFill : Constants.Image.bookmark)
  }
}
