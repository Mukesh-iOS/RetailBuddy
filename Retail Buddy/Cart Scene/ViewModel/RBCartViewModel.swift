//
//  RBCartViewModel.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

class RBCartViewModel: NSObject {
    
    var cartProducts: [Product]?
    var totalCartPrice: Double?
    
    func fetchCartProducts() {
        cartProducts = RBDatabaseOperation.getCartProducts()
        calculateTotalPrice()
    }
    
    private func calculateTotalPrice() {
        totalCartPrice = 0
        
        if let cartItems = cartProducts , cartItems.count > 0 {
            for (_, product) in cartItems.enumerated() {
                
                totalCartPrice = totalCartPrice! + (Double(product.price ?? "0")! * Double(product.productCount))
            }
        }
    }
}

