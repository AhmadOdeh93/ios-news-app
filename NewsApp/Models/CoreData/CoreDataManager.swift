//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: AppConstants.CoreData.modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // In production, handle this error appropriately
                print("Core Data error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                print("Save error: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Cache Operations
    func cacheArticles(_ articles: [Article]) {
        let context = persistentContainer.viewContext
        
        // Clear existing cached articles
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CachedArticle")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save() // Save the deletion
            
            // Save new articles
            for article in articles {
                let cachedArticle = NSEntityDescription.insertNewObject(forEntityName: "CachedArticle", into: context) as! CachedArticle
                
                cachedArticle.title = article.title
                cachedArticle.articleDescription = article.description
                cachedArticle.url = article.url
                cachedArticle.urlToImage = article.urlToImage
                cachedArticle.sourceName = article.source.name
                cachedArticle.author = article.author
                cachedArticle.publishedAt = article.publishedAt
            }
            
            try context.save()
            print("Successfully cached \(articles.count) articles")
            
        } catch {
            print("Failed to cache articles: \(error)")
        }
    }
    
    func loadCachedArticles() -> [Article] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<CachedArticle> = NSFetchRequest(entityName: "CachedArticle")
        
        do {
            let cachedArticles = try context.fetch(request)
            let articles = cachedArticles.compactMap { cached -> Article? in
                guard let title = cached.title,
                      let url = cached.url else {
                    return nil
                }
                
                return Article(
                    source: Source(id: nil, name: cached.sourceName ?? "Unknown"),
                    author: cached.author,
                    title: title,
                    description: cached.articleDescription,
                    url: url,
                    urlToImage: cached.urlToImage,
                    publishedAt: cached.publishedAt ?? "",
                    content: nil
                )
            }
            
            print("Loaded \(articles.count) cached articles")
            return articles
            
        } catch {
            print("Failed to load cached articles: \(error)")
            return []
        }
    }
    
    // MARK: - Clear Cache
    func clearCache() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: AppConstants.CoreData.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Cache cleared successfully")
        } catch {
            print("Failed to clear cache: \(error)")
        }
    }
}
