//
//  Delay.swift
//  MovieDB-VIP
//
//  Created by Dayton on 20/01/22.
//

import Foundation

struct Delay {
  static func wait(delay: Double = 0.2, completion: @escaping() -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      completion()
    }
  }

  static func execute(completion: @escaping() -> Void) {
    DispatchQueue.main.async {
      completion()
    }
  }
}
