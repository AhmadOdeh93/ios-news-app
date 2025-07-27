//
//  ArticleDetailViewModel.swift
//  NewsApp
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import Foundation

class ArticleDetailViewModel {
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    // MARK: - Computed Properties for View
    var title: String {
        return article.title
    }
    
    var sourceName: String {
        return article.source.name
    }
    
    var authorText: String {
        guard let author = article.author else { return "" }
        return "By \(author)"
    }
    
    var description: String {
        return article.description ?? ""
    }
    
    var imageURL: URL? {
        guard let urlString = article.urlToImage else { return nil }
        return URL(string: urlString)
    }
    
    var hasImage: Bool {
        return imageURL != nil
    }
    
    var publishedDate: String {
        return article.publishedAt
    }
    
    var hasAuthor: Bool {
        return article.author != nil
    }
}
