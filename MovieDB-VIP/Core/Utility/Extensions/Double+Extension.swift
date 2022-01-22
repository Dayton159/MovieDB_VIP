//
//  Double+Extension.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import Foundation

extension Double {
  func toString(digit: Int = 1) -> String? {
    return String(format: "%.\(digit)f", self)
  }
}
