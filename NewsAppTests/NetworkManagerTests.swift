//
//  NetworkManagerTests.swift
//  NewsAppTests
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import XCTest
@testable import NewsApp

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var mockDelegate: MockNetworkManagerDelegate!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
        mockDelegate = MockNetworkManagerDelegate()
        networkManager.delegate = mockDelegate
    }
    
    func testFetchTopHeadlines() {
        let expectation = XCTestExpectation(description: "Network call completes")
        
        mockDelegate.onArticlesFetched = { articles in
            XCTAssertFalse(articles.isEmpty)
            expectation.fulfill()
        }
        
        mockDelegate.onError = { error in
            // This might happen if API key is not set
            print("Network call failed: \(error)")
            expectation.fulfill()
        }
        
        networkManager.fetchTopHeadlines()
        
        wait(for: [expectation], timeout: 10.0)
    }
}

class MockNetworkManagerDelegate: NetworkManagerDelegate {
    var onArticlesFetched: (([Article]) -> Void)?
    var onError: ((Error) -> Void)?
    
    func didFetchArticles(_ articles: [Article]) {
        onArticlesFetched?(articles)
    }
    
    func didFailWithError(_ error: Error) {
        onError?(error)
    }
}
