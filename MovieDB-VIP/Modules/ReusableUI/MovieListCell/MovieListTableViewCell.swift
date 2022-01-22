//
//  MovieListTableViewCell.swift
//  MovieDB-VIP
//
//  Created by Dayton on 20/01/22.
//

import UIKit

class MovieListTableViewCell: UITableViewCell, Reusable {
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
    self.movieImageView.image = data.asyncImage.image
    self.movieTitle.text = data.title
    self.movieOverview.text = data.overview
    self.releasedDateValue.text = data.releaseDate
    
    data.asyncImage.completeDownload = { [weak self] image in
      guard let image = image else { return }
      self?.movieImageView.image = image
    }
    
    data.asyncImage.startDownloading()
  }
}

