//
//  ArticleElementTextCell.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

final class ArticleElementTextCell: UITableViewCell {
    
    @IBOutlet weak var articleBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    /**
     Configures the cell with the given view model.
    
     - Parameter elementViewModel: The view model.
    */
    func configure(with elementViewModel: ArticleTextElementViewModel) {
        self.articleBodyLabel.text = elementViewModel.text
    }
}
