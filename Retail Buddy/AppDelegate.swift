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
        RBDatabaseOperation.initializeDBWithMockJsonDatas()
        
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
}
