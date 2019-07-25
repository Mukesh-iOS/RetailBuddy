//
//  RBCategoryViewController.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

class RBCategoryViewController: UIViewController {
    
    @IBOutlet weak var electronicsView: UIView!
    @IBOutlet weak var furnituresView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initialSetup()
    }
    
    private func initialSetup() {
        let electronicsViewGesture = UITapGestureRecognizer(target: self, action: #selector(electronicsViewTapped(_:)))
        electronicsView.addGestureRecognizer(electronicsViewGesture)
        
        let furnituresViewGesture = UITapGestureRecognizer(target: self, action: #selector(furnituresViewTapped(_:)))
        furnituresView.addGestureRecognizer(furnituresViewGesture)
    }
    
    // MARK: Tap Gesture Actions
    
    @objc func electronicsViewTapped(_ sender: UITapGestureRecognizer) {

        pushToListViewControllerWith(category: ProductIdentifiers.electronics.rawValue)
    }
    
    @objc func furnituresViewTapped(_ sender: UITapGestureRecognizer) {

        pushToListViewControllerWith(category: ProductIdentifiers.furnitures.rawValue)
    }
    
    // MARK: Push to List View Controller
    
    private func pushToListViewControllerWith( category: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listVC = storyboard.instantiateViewController(withIdentifier: RBListViewController.identifier) as? RBListViewController
        
        if let listVC = listVC {
            listVC.categoryType = category
            self.navigationController?.pushViewController(listVC, animated: true)
        }
    }
    
    // MARK: Button Actions
    
    @IBAction func cartBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: RBCartViewController.identifier) as? RBCartViewController
        
        if let cartVC = cartVC {
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        electronicsView.gestureRecognizers?.removeFirst()
        furnituresView.gestureRecognizers?.removeFirst()
    }
}
