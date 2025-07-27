//
//  AppConstants.swift
//  NewsApp
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import Foundation

struct AppConstants {
    struct API {
        static let baseURL = "https://newsapi.org/v2"
        static let apiKey = "617e43455f7e4b23813adcf1b86574cb"
        static let country = "us"
    }
    
    struct UI {
        static let cellHeight: CGFloat = 100
        static let imageCornerRadius: CGFloat = 8
        static let defaultPadding: CGFloat = 16
    }
    
    struct CoreData {
        static let modelName = "NewsApp"
        static let entityName = "CachedArticle"
    }
}
