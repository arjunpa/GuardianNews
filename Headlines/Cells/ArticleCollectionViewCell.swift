//
//  ArticleCollectionViewCell.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var articleElementTableView: UITableView! {
        didSet {
            self.articleElementTableView.separatorStyle = .none
        }
    }
    
    private lazy var elementsDataSource = ArticleElementsDataSource()
    
    /**
     Configures the cell with the given view model
    
     - Parameter articleViewModel: The view model
    */
    func configure(with articleViewModel: ArticleViewModel) {
        self.articleElementTableView.rowHeight = articleViewModel.rowHeight
        self.articleElementTableView.sectionFooterHeight = articleViewModel.footerHeight
        self.elementsDataSource.articleViewModel = articleViewModel
        self.articleElementTableView.delegate = self.elementsDataSource
        self.articleElementTableView.dataSource = self.elementsDataSource
        self.articleElementTableView.reloadData()
    }
    
    /// Reset the content offset to the starting position of the scroll.
    func resetContentOffset() {
        self.articleElementTableView.setContentOffset(CGPoint.zero, animated: false)
    }
}
