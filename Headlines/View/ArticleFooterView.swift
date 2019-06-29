//
//  ArticleFooterView.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ArticleFooterView: UITableViewHeaderFooterView {

    var isFavoritSelected: Bool = false
    
    var didInteractWithFavorite: ((Bool) -> Void)?
    
    var didInteractWithFavoriteList: (() -> Void)?
    
    @IBAction private func didTapOnFavorite() {
        self.isFavoritSelected = !self.isFavoritSelected
        self.didInteractWithFavorite?(self.isFavoritSelected)
    }
    
    @IBAction private func didTapOnFavoriteList() {
        self.didInteractWithFavoriteList?()
    }
}
