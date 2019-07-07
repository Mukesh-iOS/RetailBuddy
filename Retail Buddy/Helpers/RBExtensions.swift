//
//  RBExtensions.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}

extension Double {

    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension UIAlertController{
    
    class func showSimpleAlert( message : String , inViewController : UIViewController){
        let alert = UIAlertController(title: "Retail Buddy", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        inViewController.present(alert, animated: true , completion: nil)
    }
}
