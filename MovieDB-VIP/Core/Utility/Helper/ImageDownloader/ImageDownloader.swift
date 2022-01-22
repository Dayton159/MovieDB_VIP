//
//  ImageDownloader.swift
//  MovieDB-VIP
//
//  Created by Dayton on 20/01/22.
//

import UIKit

class ImageDownloader: Equatable{
  let url: String
  
  var image: UIImage? {
    return imageStore ?? placeholder
  }
  
  var completeDownload: ((UIImage?) -> Void)?
  
  private var imageStore: UIImage?
  private let placeholder: UIImage?
  
  private let service: ImageDownloaderProtocol
  
  private var isDownloading: Bool = false
  
  init(url: String,
       placeholder: UIImage? = Constants.Image.placeholder,
       service: ImageDownloaderProtocol = ImageDownloaderService()) {
    self.url = url
    self.placeholder = placeholder
    self.service = service
  }
  
  func startDownloading() {
    guard let imageStore = imageStore else {
      if isDownloading { return }
      isDownloading = true
      service.download(imgURL: url, completion: { [weak self] image in
        self?.imageStore = image
        self?.isDownloading = false
        Delay.execute {
          self?.completeDownload?(image)
        }
      })
      return
    }
    completeDownload?(imageStore)
  }
  
  func cancelDownloading() {
    self.service.cancel()
  }
  
  static func == (lhs: ImageDownloader, rhs: ImageDownloader) -> Bool {
    return lhs.url == rhs.url && lhs.isDownloading == rhs.isDownloading
  }
}
