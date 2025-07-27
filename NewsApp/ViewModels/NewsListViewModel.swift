//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import Foundation

protocol NewsListViewModelDelegate: AnyObject {
    func didUpdateArticles()
    func didStartLoading()
    func didFinishLoading()
    func didFailWithError(_ error: Error)
}

class NewsListViewModel {
    // MARK: - Properties
    weak var delegate: NewsListViewModelDelegate?
    
    private(set) var articles: [Article] = [] {
        didSet {
            delegate?.didUpdateArticles()
        }
    }
    
    private(set) var isLoading: Bool = false {
        didSet {
            if isLoading {
                delegate?.didStartLoading()
            } else {
                delegate?.didFinishLoading()
            }
        }
    }
    
    private let networkManager = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    // MARK: - Initialization
    init() {
        networkManager.delegate = self
        loadCachedArticles()
    }
    
    // MARK: - Public Methods
    func fetchArticles() {
        isLoading = true
        networkManager.fetchTopHeadlines()
    }
    
    func refreshArticles() {
        fetchArticles()
    }
    
    func numberOfArticles() -> Int {
        return articles.count
    }
    
    func article(at index: Int) -> Article {
        return articles[index]
    }
    
    // MARK: - Private Methods
    private func loadCachedArticles() {
        articles = coreDataManager.loadCachedArticles()
    }
    
    private func cacheArticles() {
        coreDataManager.cacheArticles(articles)
    }
}

// MARK: - NetworkManagerDelegate
extension NewsListViewModel: NetworkManagerDelegate {
    func didFetchArticles(_ articles: [Article]) {
        self.articles = articles
        cacheArticles()
        isLoading = false
    }
    
    func didFailWithError(_ error: Error) {
        isLoading = false
        delegate?.didFailWithError(error)
    }
}
