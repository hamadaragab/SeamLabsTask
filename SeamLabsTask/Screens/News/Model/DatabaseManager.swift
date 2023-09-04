//
//  DatabaseManager.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
import CoreData
class DatabaseManager {
    
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    func saveNewArticls(_ articls: [Articles]) {
        // delete prevoius saved articls before add the newest
        deletePreviousSavedArticls()
        for articl in articls {
            let articleEntity = ArticlesData(context: context)
            articleEntity.author = articl.author
            articleEntity.title = articl.title ?? ""
            articleEntity.content = articl.content ?? ""
            articleEntity.description2 = articl.description  ?? ""
            articleEntity.publishedAt = articl.publishedAt ?? ""
            articleEntity.url = articl.url ?? ""
            articleEntity.urlToImage = articl.urlToImage ?? ""
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving Articls to Core Data: \(error.localizedDescription)")
        }
    }
    func deletePreviousSavedArticls() {
        let request: NSFetchRequest<ArticlesData> = ArticlesData.fetchRequest()
        do {
            let results = try context.fetch(request)
            for result in results {
                context.delete(result)
            }
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    func fetchSavedArticles() -> [Articles] {
        let request: NSFetchRequest<ArticlesData> = ArticlesData.fetchRequest()
        var savedArticles:[Articles] =  []
        do {
            savedArticles = try context.fetch(request).map{
                Articles(savedArticle: $0)
            }
            
        } catch let error {
            print("Error fetching data: \(error.localizedDescription)")
        }
        return savedArticles
    }
}
