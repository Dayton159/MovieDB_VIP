//
//  AppCoordinator.swift
//  MovieDB-VIP
//
//  Created by Dayton on 20/01/22.
//

import UIKit

class AppCoordinator {
  private let window: UIWindow
  private let mainRouter: AppRouter

  init(window: UIWindow, mainRouter: AppRouter) {
    self.window = window
    self.mainRouter = mainRouter
  }

  func start() {
    window.rootViewController = mainRouter.makeMainView()
    window.makeKeyAndVisible()

    UIView.transition(with: window,
                      duration: 0.5,
                      options: .transitionCrossDissolve,
                      animations: nil,
                      completion: nil)
  }
}
