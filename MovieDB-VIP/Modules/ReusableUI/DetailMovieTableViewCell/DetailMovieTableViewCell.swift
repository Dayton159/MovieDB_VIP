//
//  DetailMovieTableViewCell.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import UIKit

class DetailMovieTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var movieOverview: UILabel!
  @IBOutlet weak var releasedDateValue: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configureCell(data: MovieModel) {
    self.movieImageView.image = data.asyncPoster.image
    self.movieTitle.text = data.title
    self.movieOverview.text = data.overview
    self.releasedDateValue.text = data.releaseDate
    
    data.asyncPoster.completeDownload = { [weak self] image in
      guard let image = image else { return }
      self?.movieImageView.image = image
    }
    
    data.asyncPoster.startDownloading()
  }
}
