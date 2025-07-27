//
//  NewsListViewModelTests.swift
//  NewsAppTests
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import XCTest
@testable import NewsApp

class NewsListViewModelTests: XCTestCase {
    var viewModel: NewsListViewModel!
    var mockDelegate: MockNewsListViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        viewModel = NewsListViewModel()
        mockDelegate = MockNewsListViewModelDelegate()
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.numberOfArticles(), 0)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFetchArticlesStartsLoading() {
        let expectation = XCTestExpectation(description: "Loading starts")
        
        mockDelegate.onDidStartLoading = {
            expectation.fulfill()
        }
        
        viewModel.fetchArticles()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(viewModel.isLoading)
    }
    
    func testRefreshArticles() {
        let expectation = XCTestExpectation(description: "Refresh starts loading")
        
        mockDelegate.onDidStartLoading = {
            expectation.fulfill()
        }
        
        viewModel.refreshArticles()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(viewModel.isLoading)
    }
}

class MockNewsListViewModelDelegate: NewsListViewModelDelegate {
    var onDidUpdateArticles: (() -> Void)?
    var onDidStartLoading: (() -> Void)?
    var onDidFinishLoading: (() -> Void)?
    var onDidFailWithError: ((Error) -> Void)?
    
    func didUpdateArticles() {
        onDidUpdateArticles?()
    }
    
    func didStartLoading() {
        onDidStartLoading?()
    }
    
    func didFinishLoading() {
        onDidFinishLoading?()
    }
    
    func didFailWithError(_ error: Error) {
        onDidFailWithError?(error)
    }
}
