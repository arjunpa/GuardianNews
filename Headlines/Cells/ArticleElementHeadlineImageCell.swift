//
//  ArticleElementHeadlineImageCell.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SDWebImage

final class ArticleElementHeadlineImageCell: UITableViewCell {

    @IBOutlet private weak var articleHeadline: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    /**
     Configure the cell with the given view model
    
     - Parameter elementViewModel: The view model
    */
    func configure(with elementViewModel: ArticleHeadlineElementViewModel) {
        self.articleHeadline.text = elementViewModel.headline
        self.articleImageView.sd_setImage(with: elementViewModel.imageURL)
    }
}
