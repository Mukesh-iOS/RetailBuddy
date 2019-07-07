//
//  RBDatabaseOperation.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit
import CoreData

enum Identification: String {
    case price = "price"
    case currency = "currency"
    case productId = "id"
    case title = "title"
    case productType = "type"
    case isAddedToCart = "isAddedToCart"
    case category = "category"
}

class RBDatabaseOperation: NSObject{
    
    // MARK: Saving Context
    
    class func saveContext() {
        let context = RBDatabaseManager.sharedInstance.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: Inserting Data into DB
    
    class func insertDatasInDBWith(lists: NSArray, forCategory: String) {
        let managedContext = RBDatabaseManager.sharedInstance.managedObjectContext
        
        for case let item as NSDictionary in lists {
            
            guard let productID = item.value(forKey: Identification.productId.rawValue) as? NSInteger else {
                return
            }
            
            if !checkIfAlreadyInsertedWith(id: productID) {
                if let entity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext) {
                    
                    let product = Product(entity: entity, insertInto: managedContext)
                    
                    product.price = item.value(forKey: Identification.price.rawValue) as? String ?? "0"
                    product.productId = Int64(productID)
                    product.title = item.value(forKey: Identification.title.rawValue) as? String ?? "No title"
                    product.type = item.value(forKey: Identification.productType.rawValue) as? String ?? "No type availabe"
                    product.isAddedToCart = false
                    product.productCount = 0
                    product.category = forCategory
                }
            }
        }
        RBDatabaseOperation.saveContext()
    }
    
    // MARK: Check Duplication
    
    class func checkIfAlreadyInsertedWith(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "productId = %d", Int64(id))
        
        var fetchResults: [NSManagedObject] = []
        
        do {
            fetchResults = try RBDatabaseManager.sharedInstance.managedObjectContext.fetch(fetchRequest)
        }
        catch let error as NSError {
            debugPrint("error executing fetch request: \(error.localizedDescription)")
        }
        return fetchResults.count > 0
    }
    
    // MARK: Update Cart Details in DB
    
    class func updateCartDetailsForProductID(productID: Int64, isAddingToCart: Bool) {
        let context: NSManagedObjectContext = RBDatabaseManager.sharedInstance.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "productId = %d", productID)
        
        do {
            if let fetchResults = try context.fetch(fetchRequest) as? [Product] , fetchResults.count > 0 {
                let product = fetchResults[0]
                product.isAddedToCart = isAddingToCart
                product.productCount = isAddingToCart ? product.productCount + 1 : 0
                RBDatabaseOperation.saveContext()
            }
        }
        catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
    }
    
    // MARK: Get Products from DB
    
    class func getProductsFor(category: String) -> [Product]? {
        let context: NSManagedObjectContext = RBDatabaseManager.sharedInstance.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "category = %@", category)
        
        do {
            if let fetchResults = try context.fetch(fetchRequest) as? [Product] , fetchResults.count > 0 {
                return fetchResults
            }
        }
        catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    // MARK: Get Cart Details
    
    class func getCartProducts() -> [Product]? {
        let context: NSManagedObjectContext = RBDatabaseManager.sharedInstance.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "isAddedToCart == %@", NSNumber(value: true))
        
        do {
            if let fetchResults = try context.fetch(fetchRequest) as? [Product] , fetchResults.count > 0 {
                return fetchResults
            }
        }
        catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
}
