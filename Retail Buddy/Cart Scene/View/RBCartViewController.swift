//
//  RBCartViewController.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

private enum RBCartViewConstants: CGFloat {
    case cartTableHeight = 300
}

class RBCartViewController: UIViewController {
    
    private var cartViewModel: RBCartViewModel?
    
    static let identifier = "CartViewController"
    private static let cartCell = "CartCell"
    
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cartTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartViewModel = RBCartViewModel()
        cartTable.rowHeight = UITableView.automaticDimension
        cartTable.estimatedRowHeight = 250
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cartViewSetup()
    }
    
    private func cartViewSetup() {
        cartViewModel?.fetchCartProducts()
        productCount.text = cartViewModel?.getProductCount()
        totalPrice.text = cartViewModel?.getTotalPrice()
        cartTable.reloadData()
    }
    
    // MARK: Button Actions
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func removeProductBtnTapped(_ sender: UIButton) {
        
        cartViewModel?.removeCartItemAtIndex(sender.tag)
        cartViewSetup()
        cartTable.reloadData()
        
        UIAlertController.showSimpleAlert(message: "Product(s) removed successfully", inViewController: self)
    }
}

extension RBCartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let totalCount = cartViewModel?.getCartProductsCount() else{
            
            return 0
        }
        return totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RBCartViewController.cartCell, for: indexPath) as? RBCartCell
        
        guard let cartCell = cell else {
            
            return UITableViewCell()
        }
        
        cartCell.removeProductBtn.tag = indexPath.row
        let productData = cartViewModel?.getCartData(withIndex: indexPath.row)
        cartCell.setDataFor(product: productData)
        return cartCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return RBCartViewConstants.cartTableHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let listDetailVC = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count ?? 0) - 2] as? RBListDetailViewController {
            listDetailVC.productInfo = cartViewModel?.getCartData(withIndex: indexPath.row)
            self.navigationController?.popToViewController(listDetailVC, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let listDetailVC = storyboard.instantiateViewController(withIdentifier: RBListDetailViewController.identifier) as? RBListDetailViewController
            
            if let listDetailVC = listDetailVC {
                
                listDetailVC.productInfo = cartViewModel?.getCartData(withIndex: indexPath.row)
                self.navigationController?.pushViewController(listDetailVC, animated: true)
            }
        }
    }
}
