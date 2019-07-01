//
//  FavouriteArticleTableViewCell.swift
//  Headlines
//
//  Created by Arjun P A on 30/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SDWebImage

class FavouriteArticleTableViewCell: UITableViewCell {

    @IBOutlet private weak var headlineLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!
    
    func configure(with viewModel: FavouriteArticleViewModel) {
        self.headlineLabel.text = viewModel.headline
        self.dateLabel.text = viewModel.date
        self.articleImageView.sd_setImage(with: viewModel.imageURL)
    }
    
    override func prepareForReuse() {
        self.articleImageView.sd_cancelCurrentImageLoad()
        self.articleImageView.image = nil
    }
}

