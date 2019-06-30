//
//  FavouritesViewController.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import SDWebImage

class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class FavouritesViewController: UIViewController {
    
    private static let nibName = "FavouritesViewController"
    
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

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: "cell")
        
        self.favouriteArticleListViewModel?.fetchFavouriteArticles(with: nil)
    }
    
    @objc func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = favouriteArticleViewModel.headline
        cell.detailTextLabel?.text = favouriteArticleViewModel.date
        //cell.imageView?.sd_setImage(with: article.imageURL)
        
        return cell
    }
}

extension FavouritesViewController: FavouriteArticleListViewDelegate {
    
    func updateView() {
        self.tableView.reloadData()
    }
}
