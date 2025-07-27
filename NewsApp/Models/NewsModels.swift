//
//  NewsModels.swift
//  NewsApp
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    // Custom ID for table view
    var id: String {
        return url
    }
}

struct Source: Codable {
    let id: String?
    let name: String
}
