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
    
    @IBOutlet private weak var articleCollectionView: UICollectionView! {
        didSet {
            self.articleCollectionView.delegate = self
            self.articleCollectionView.dataSource = self
            self.articleCollectionView.isPagingEnabled = true
            if let flowLayout = self.articleCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumInteritemSpacing = 0.0
                flowLayout.minimumLineSpacing = 0.0
                flowLayout.scrollDirection = .horizontal
            }
            self.registerCells()
        }
    }
    
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
        self.articleListViewModel?.fetchArticles()
    }

    @IBAction func favouritesButtonPressed() {
        let vc = FavouritesViewController()
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true, completion: nil)
    }
    
    @IBAction func starButtonPressed() {
        // TODO: Handle favouriting
    }
    
    private func registerCells() {
        self.articleCollectionView.register(UINib(nibName: ArticleCollectionViewCell.nibName, bundle: nil),
                                            forCellWithReuseIdentifier: ArticleCollectionViewCell.reuseIdentifier)
    }
}

extension ArticleViewController: ArticleListViewDelegate {
    
    func updateView() {
        self.articleCollectionView.reloadData()
    }
}

extension ArticleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleListViewModel?.articleCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let articleViewModel = self.articleListViewModel?.article(at: indexPath.item),
              let articleCell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.reuseIdentifier,
                                                                   for: indexPath) as? ArticleCollectionViewCell
              else {
                return UICollectionViewCell()
        }
        articleViewModel.onFavoriteUpdate = { status in
            self.articleListViewModel?.updateFavorite(for: articleViewModel, with: status)
        }
        articleCell.configure(with: articleViewModel)
        return articleCell
    }
}

extension ArticleViewController: UICollectionViewDelegate {}

extension ArticleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.articleCollectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? ArticleCollectionViewCell)?.resetContentOffset()
    }
}
