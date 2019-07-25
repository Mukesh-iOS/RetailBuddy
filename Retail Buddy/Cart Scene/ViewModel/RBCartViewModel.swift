//
//  RBCartViewModel.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

class RBCartViewModel: NSObject {
    
    private var cartProducts: [Product]?
    private var totalCartPrice: Double?
    
    func fetchCartProducts() {
        cartProducts = RBDatabaseOperation.getCartProducts()
        calculateTotalPrice()
    }
    
    func getCartData(withIndex index: Int) -> Product? {
        
        return cartProducts?[index]
    }
    
    func getCartProductsCount() -> Int {
        
        return cartProducts?.count ?? 0
    }
    
    func getProductCount() -> String {
     
        guard let productCount = cartProducts?.count else {
            
            return "No of product(s): 0"
        }
        
        return "No of product(s): \(productCount)"
    }
    
    func getTotalPrice() -> String {
        
        guard let totalPrice = totalCartPrice?.format(f: ".2") else {
            
            return "0"
        }
        return "Total Price: $\(totalPrice)"
    }
    
    func removeCartItemAtIndex(_ index: Int) {
        
        if let product = cartProducts?[index] {
            
            RBDatabaseOperation.updateCartDetailsForProductID(productID: product.productId, isAddingToCart: false)
        }
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

