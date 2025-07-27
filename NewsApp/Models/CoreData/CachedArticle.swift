//
//  CachedArticle.swift
//  NewsApp
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import Foundation
import CoreData

@objc(CachedArticle)
public class CachedArticle: NSManagedObject {
    
}

extension CachedArticle {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedArticle> {
        return NSFetchRequest<CachedArticle>(entityName: AppConstants.CoreData.entityName)
    }
    
    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var author: String?
    @NSManaged public var publishedAt: String?
}

extension CachedArticle : Identifiable {
    
}
