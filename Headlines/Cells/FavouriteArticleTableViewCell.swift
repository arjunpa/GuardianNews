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
    
    /**
    Configures the cell with the given view model.
    
    - Parameter viewModel: The view model.
    */
    func configure(with viewModel: FavouriteArticleViewModel) {
        self.headlineLabel.text = viewModel.headline
        self.dateLabel.text = viewModel.date
        self.articleImageView.sd_setImage(with: viewModel.imageURL)
    }
    
    override func prepareForReuse() {
        // Ensures the reused cell doesn't show a old image and also that the image download associated with the old one is cancelled before reuse.
        
        self.articleImageView.sd_cancelCurrentImageLoad()
        self.articleImageView.image = nil
    }
}

