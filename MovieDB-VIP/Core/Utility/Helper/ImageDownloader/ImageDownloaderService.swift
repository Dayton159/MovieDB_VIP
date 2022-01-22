//
//  ImageDownloaderService.swift
//  MovieDB-VIP
//
//  Created by Dayton on 20/01/22.
//

import UIKit

protocol ImageDownloaderProtocol {
  func download(imgURL: String, completion: @escaping (UIImage?) -> ())
  func cancel()
}

class ImageDownloaderService: ImageDownloaderProtocol {
  
  private let session: URLSession
  private var dataTask: URLSessionDataTask?
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func download(imgURL: String, completion: @escaping (UIImage?) -> ()) {
    let urlStr = Environment.imageLoaderURL + imgURL
    
    guard let supportSpace = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL(string: supportSpace) else { return }
    
    self.dataTask = session.dataTask(with: url) { data, _ , _ in
      if let data = data {
        completion(UIImage(data: data))
      } else {
        completion(nil)
      }
    }
    
    dataTask?.resume()
  }
  
  func cancel() {
    dataTask?.cancel()
  }
}
