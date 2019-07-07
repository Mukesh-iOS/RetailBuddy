//
//  RBListDetailViewController.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

private enum RBListDetailViewIdentifiers: String {
    case title = "Product Details"
    case cartVC = "CartViewController"
}

class RBListDetailViewController: UIViewController {
    
    var productInfo: Product?
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPic: UIImageView!
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = RBListDetailViewIdentifiers.title.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showProductInfo()
    }
    
    private func showProductInfo() {
        productPic.image = UIImage.init(named: productInfo?.category?.capitalizingFirstLetter() ?? "")
        productTitle.text = productInfo?.title
        productType.text = "Type: \(productInfo?.type ?? "")"
        productPrice.text = "Price: $\(productInfo?.price ?? "0")"
    }
    
    // MARK: Button Actions
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: RBListDetailViewIdentifiers.cartVC.rawValue) as? RBCartViewController
        if let cartVC = cartVC {
            
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    
    @IBAction func addToCartBtnTapped(_ sender: Any) {
        
        RBDatabaseOperation.updateCartDetailsForProductID(productID: productInfo?.productId ?? 0, isAddingToCart: true)
        
        UIAlertController.showSimpleAlert(message: "Added to cart successfully", inViewController: self)
    }
}
