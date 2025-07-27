//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func didFetchArticles(_ articles: [Article])
    func didFailWithError(_ error: Error)
}

class NetworkManager {
    static let shared = NetworkManager()
    weak var delegate: NetworkManagerDelegate?
    
    private let apiKey = AppConstants.API.apiKey
    private let baseURL = AppConstants.API.baseURL
    
    private init() {}
    
    func fetchTopHeadlines() {
        guard let url = URL(string: "\(baseURL)/top-headlines?country=\(AppConstants.API.country)&apiKey=\(apiKey)") else {
            delegate?.didFailWithError(NetworkError.invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.delegate?.didFailWithError(error)
                    return
                }
                
                guard let data = data else {
                    self?.delegate?.didFailWithError(NetworkError.noData)
                    return
                }
                
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    self?.delegate?.didFetchArticles(newsResponse.articles)
                } catch {
                    self?.delegate?.didFailWithError(error)
                }
            }
        }
        
        task.resume()
    }
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        }
    }
}
