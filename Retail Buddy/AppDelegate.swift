//
//  AppDelegate.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit
import CoreData

enum ProductIdentifiers: String {
    case categories = "categories"
    case electronics = "electronics"
    case furnitures = "furnitures"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Set navigation style
        setNavigationStyle()
        initializeDBWithJsonDatas()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        RBDatabaseOperation.saveContext()
    }
    
    // MARK: Initial Setup
    
    private func setNavigationStyle() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 8.0/255.0, green: 96.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    private func initializeDBWithJsonDatas() {
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                guard let jsonResult = result as? NSDictionary else {

                    return
                }
                debugPrint(jsonResult)
                
                let results = (jsonResult.value(forKey: ProductIdentifiers.categories.rawValue) as? NSArray)?.firstObject as? NSDictionary
                
                if let electronics = (results?.value(forKey: ProductIdentifiers.electronics.rawValue) as? NSArray) , electronics.count > 0 {
                    // Will check for duplicate before insertion
                    RBDatabaseOperation.insertDatasInDBWith(lists: electronics, forCategory: ProductIdentifiers.electronics.rawValue)
                }
                
                if let furnitures = (results?.value(forKey: ProductIdentifiers.furnitures.rawValue) as? NSArray) , furnitures.count > 0 {
                    // Will check for duplicate before insertion
                    RBDatabaseOperation.insertDatasInDBWith(lists: furnitures, forCategory: ProductIdentifiers.furnitures.rawValue)
                }
            } catch let error as NSError {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
