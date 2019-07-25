//
//  RBListViewController.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

class RBListViewController: UIViewController {

    @IBOutlet weak var listTable: UITableView!
    
    static let identifier = "ListViewController"
    private static let listCell = "ListCell"
    
    private var listViewModel: RBListViewModel?
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
        listViewModel = RBListViewModel()
        listViewModel?.fetchProductsFor(Category: categoryType)
        
        listTable.rowHeight = UITableView.automaticDimension
        listTable.estimatedRowHeight = 100
    }
    
    // MARK: Button Actions
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: RBCartViewController.identifier) as? RBCartViewController
        
        if let cartVC = cartVC {
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
}

extension RBListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let totalCount = listViewModel?.getTotalCount() else {
            
            return 0
        }
        return totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RBListViewController.listCell, for: indexPath) as? RBListCell
        guard let listCell = cell else {
            
            return UITableViewCell()
        }
        
        listCell.setDatawith(product: listViewModel?.getProductInfo(withIndex: indexPath.row))
        return listCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listDetailVC = storyboard.instantiateViewController(withIdentifier: RBListDetailViewController.identifier) as? RBListDetailViewController
        if let listDetailVC = listDetailVC {
            
            listDetailVC.productInfo = listViewModel?.getProductInfo(withIndex: indexPath.row)
            self.navigationController?.pushViewController(listDetailVC, animated: true)
        }
    }
}
