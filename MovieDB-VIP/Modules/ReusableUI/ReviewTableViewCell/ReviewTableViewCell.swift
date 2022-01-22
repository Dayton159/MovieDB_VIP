//
//  ReviewTableViewCell.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configureCell(data: ReviewModel) {
    self.avatarImageView.image = data.avatar.image
    self.nameLabel.text = data.author
    self.dateLabel.text = data.date
    self.ratingLabel.text = data.rating
    
    data.avatar.completeDownload = { [weak self] image in
      guard let image = image else { return }
      self?.avatarImageView.image = image
    }
    
    data.avatar.startDownloading()
  }
}
