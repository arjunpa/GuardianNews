//
//  ArticleFooterView.swift
//  Headlines
//
//  Created by Arjun P A on 29/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ArticleFooterView: UITableViewHeaderFooterView {

    private struct Constants {
        static let favoriteButtonImageWhenOn = "favourite-on"
        static let favoriteButtonImageWhenOff = "favourite-off"
    }
    
    @IBOutlet private weak var favoriteButton: UIButton!
    
    var isFavoritSelected: Bool = false {
        didSet {
            self.favoriteButton.isSelected = self.isFavoritSelected
        }
    }
    
    var didInteractWithFavorite: ((Bool) -> Void)?
    
    var onShowFavorites: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.favoriteButton.tintColor = UIColor.white
        self.favoriteButton.setBackgroundImage(UIImage(named: Constants.favoriteButtonImageWhenOn), for: .selected)
        self.favoriteButton.setBackgroundImage(UIImage(named: Constants.favoriteButtonImageWhenOff), for: .normal)
    }
    
    @IBAction private func didTapOnFavorite() {
        self.isFavoritSelected = !self.isFavoritSelected
        self.didInteractWithFavorite?(self.isFavoritSelected)
    }
    
    @IBAction private func didTapOnFavoriteList() {
        self.onShowFavorites?()
    }
}
