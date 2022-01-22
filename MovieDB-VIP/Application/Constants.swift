//
//  Constants.swift
//  MovieDB-VIP
//
//  Created by Dayton on 20/01/22.
//

import UIKit

struct Constants {
  
  struct Image {
    static let category = UIImage(systemName: "doc.text.magnifyingglass")
    static let fav = UIImage(systemName: "heart")

    static let placeholder = UIImage(named: "image_default")
    static let avatarPlaceholder = UIImage(systemName: "person.fill")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)

    static let bookmark = UIImage(systemName: "bookmark")
    static let bookmarkFill = UIImage(systemName: "bookmark.fill")
  }
  
  struct Font {
    static func regular(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Regular", size: size) else { fatalError("Lato-Regular Not Found")}
      return font
    }

    static func semibold(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Semibold", size: size) else { fatalError("Lato-Semibold Not Found")}
      return font
    }

    static func bold(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Bold", size: size) else { fatalError("Lato-Bold Not Found")}
      return font
    }
  }
}
