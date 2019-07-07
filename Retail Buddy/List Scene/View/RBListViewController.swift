//
//  RBListViewController.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

private enum RBListViewIdentifiers: String {
    case cartVC = "CartViewController"
    case listCell = "ListCell"
    case ListDetailVC = "ListDetailViewController"
}

class RBListViewController: UIViewController {

    @IBOutlet weak var listTable: UITableView!
    
    private var ListViewModel: RBListViewModel?
    var categoryType: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        
        self.title = categoryType?.capitalizingFirstLetter() 
        
        guard let categoryType = categoryType else {
            
            return
        }
        ListViewModel = RBListViewModel()
        ListViewModel?.fetchProductsFor(Category: categoryType)
        
        listTable.rowHeight = UITableView.automaticDimension
        listTable.estimatedRowHeight = 100
    }
    
    // MARK: Button Actions
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: RBListViewIdentifiers.cartVC.rawValue) as? RBCartViewController
        
        if let cartVC = cartVC {
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
}

extension RBListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ListViewModel?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RBListViewIdentifiers.listCell.rawValue, for: indexPath) as? RBListCell
        guard let listCell = cell else {
            
            return UITableViewCell()
        }
        
        listCell.setDatawith(product: ListViewModel?.products?[indexPath.row])
        return listCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listDetailVC = storyboard.instantiateViewController(withIdentifier: RBListViewIdentifiers.ListDetailVC.rawValue) as? RBListDetailViewController
        if let listDetailVC = listDetailVC {
            
            listDetailVC.productInfo = ListViewModel?.products?[indexPath.row]
            self.navigationController?.pushViewController(listDetailVC, animated: true)
        }
    }
}
