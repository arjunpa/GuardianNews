//
//  FavouritesViewController.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import SDWebImage

class FavouritesViewController: UIViewController {
    
    private static let nibName = "FavouritesViewController"
    
    private static let estimatedHeight: CGFloat = 40.0
    
    var articleSelected: ((IndexPath) -> Void)?
    
    var favouriteArticleListViewModel: FavouriteArticleListViewModel?
    
    @IBOutlet private weak var tableView: UITableView!
    
    init(with favouriteArticleListViewModel: FavouriteArticleListViewModel) {
        self.favouriteArticleListViewModel = favouriteArticleListViewModel
        super.init(nibName: type(of: self).nibName, bundle: nil)
        self.favouriteArticleListViewModel?.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favouriteArticleListViewModel?.fetchFavouriteArticles(with: nil)
        self.configure()
    }
    
    @objc func doneButtonPressed() {
        self.favouriteArticleListViewModel?.didFinish()
    }
    
    private func configure() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.register(UINib(nibName: FavouriteArticleTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: FavouriteArticleTableViewCell.reuseIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = type(of: self).estimatedHeight
    }
}

extension FavouritesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.favouriteArticleListViewModel?.fetchFavouriteArticles(with: searchText)
    }
}

extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favouriteArticleListViewModel?.numberOfArticles ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let favouriteArticleViewModel = self.favouriteArticleListViewModel?.favouriteArticle(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteArticleTableViewCell.reuseIdentifier , for: indexPath)
        
        if let favouriteTableViewCell = cell as? FavouriteArticleTableViewCell {
            favouriteTableViewCell.configure(with: favouriteArticleViewModel)
        }
        
        return cell
    }
}

extension FavouritesViewController: FavouriteArticleListViewDelegate {
    
    func updateView() {
        self.title = self.favouriteArticleListViewModel?.titleForView
        self.tableView.reloadData()
    }
}
