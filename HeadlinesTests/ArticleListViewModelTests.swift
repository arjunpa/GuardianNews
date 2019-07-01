//
//  ArticleListViewModelTests.swift
//  HeadlinesTests
//
//  Created by Arjun P A on 01/07/19.
//  Copyright © 2019 Example. All rights reserved.
//

import XCTest
@testable import Headlines

class ArticleListViewModelTests: XCTestCase {
    
    class View: ArticleListViewDelegate {
        var isUpdateViewCalled = false
        
        func updateView() {
            self.isUpdateViewCalled = true
        }
        
        init() {}
    }
    
    var articleListViewModel: ArticleListViewModel!
    var articleListDataProvider: ArticleListDataProvider!
    var articleListRemoteDataManager: RemoteDataManager!
    var localDataManager: LocalDataManager<Article>!
    var articleListClient: ArticleListService!
    var view: View!
    
    override func setUp() {
        self.articleListRemoteDataManager = RemoteDataManager()
        self.articleListClient = ArticleListService(dataManager: self.articleListRemoteDataManager)
        self.localDataManager = LocalDataManager<Article>()
        self.articleListDataProvider = ArticleListDataProvider(articleClient: self.articleListClient,
                                                               localDataManager: self.localDataManager)
        self.articleListViewModel = ArticleListViewModel(articleRepository: self.articleListDataProvider)
        self.view = View()
    }
    
    func testViewDelegateCallBack () {
        
        let predicate = NSPredicate{ view, _ -> Bool in
            guard let view = view as? View else { return false }
            return view.isUpdateViewCalled
        }
        
        _ = self.expectation(for: predicate, evaluatedWith: view, handler: nil)
        self.articleListViewModel.viewDelegate = self.view
        self.articleListViewModel.fetchArticles()
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
