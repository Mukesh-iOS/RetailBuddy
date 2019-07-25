//
//  RBListViewModel.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

class RBListViewModel: NSObject {

    private var products: [Product]?
    
    func fetchProductsFor(Category : String) {
        products = RBDatabaseOperation.getProductsFor(category: Category)
    }
    
    func getTotalCount() -> Int {
        
        return products?.count ?? 0
    }
    
    func getProductInfo (withIndex index: Int) -> Product? {
        
        return products?[index]
    }
}
