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
    
    @IBOutlet private weak var favouriteButton: UIButton!
    
    var isFavouriteSelected: Bool = false {
        didSet {
            self.favouriteButton.isSelected = self.isFavouriteSelected
        }
    }
    
    var didInteractWithFavourite: ((Bool) -> Void)?
    
    var onShowFavourites: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.favouriteButton.tintColor = UIColor.white
        self.favouriteButton.setBackgroundImage(UIImage(named: Constants.favoriteButtonImageWhenOn), for: .selected)
        self.favouriteButton.setBackgroundImage(UIImage(named: Constants.favoriteButtonImageWhenOff), for: .normal)
    }
    
    @IBAction private func didTapOnFavourite() {
        self.isFavouriteSelected = !self.isFavouriteSelected
        self.didInteractWithFavourite?(self.isFavouriteSelected)
    }
    
    @IBAction private func didTapOnFavoriteList() {
        self.onShowFavourites?()
    }
}
