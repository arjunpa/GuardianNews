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
    
    /// A bool indicating whether the favourite button is selected.
    var isFavouriteSelected: Bool = false {
        didSet {
            self.favouriteButton.isSelected = self.isFavouriteSelected
        }
    }
    
    /// A callback that is invoked when the favourite button is interacted upon.
    var didInteractWithFavourite: ((Bool) -> Void)?
    
    /// A callback that is interacted with when the show favourites button is interacted upon.
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
