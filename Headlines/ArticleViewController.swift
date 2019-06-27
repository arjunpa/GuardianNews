//
//  ArticleViewController.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import SDWebImage

final class ArticleViewController: UIViewController {
    
    private static let nibName = "ArticleViewController"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    
    var articleListViewModel: ArticleListViewModelInterface?
    
    init(with articleListViewModel: ArticleListViewModelInterface) {
        self.articleListViewModel = articleListViewModel
        super.init(nibName: type(of: self).nibName, bundle: nil)
        self.articleListViewModel?.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        reload()
//        Article.fetchArticles { _, _ in
//            self.reload()
//        }
        self.articleListViewModel?.fetchArticles()
    }
    
    func reload() {
        guard let articleViewModel = self.articleListViewModel?.article(at: 0) else { return }
        headlineLabel.text = articleViewModel.title
        bodyLabel.text = articleViewModel.body
        imageView.sd_setImage(with: articleViewModel.imageURL)
    }

    @IBAction func favouritesButtonPressed() {
        let vc = FavouritesViewController()
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true, completion: nil)
    }
    
    @IBAction func starButtonPressed() {
        // TODO: Handle favouriting
    }
}

extension ArticleViewController: ArticleListViewDelegate {
    
    func updateView() {
        self.reload()
    }
}
