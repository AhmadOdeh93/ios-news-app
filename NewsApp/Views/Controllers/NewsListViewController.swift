//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import UIKit

class NewsListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = NewsListViewModel()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refresh
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchArticles()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Top Headlines"
        view.backgroundColor = UIColor.systemBackground
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        tableView.refreshControl = refreshControl
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.delegate = self
    }
    
    // MARK: - Actions
    @objc private func refreshData() {
        viewModel.refreshArticles()
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let article = viewModel.article(at: indexPath.row)
        cell.configure(with: article)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = viewModel.article(at: indexPath.row)
        let detailViewModel = ArticleDetailViewModel(article: article)
        let detailVC = ArticleDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - NewsListViewModelDelegate
extension NewsListViewController: NewsListViewModelDelegate {
    func didUpdateArticles() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didStartLoading() {
        DispatchQueue.main.async {
            if self.viewModel.numberOfArticles() == 0 {
                self.loadingIndicator.startAnimating()
            }
        }
    }
    
    func didFinishLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
    
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.showError(error)
        }
    }
}
