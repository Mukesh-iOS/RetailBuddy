//
//  RBListCell.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

class RBListCell: UITableViewCell {

    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func setDatawith(product: Product?) {
        
        productTitle.text = product?.title ?? ""
        productType.text = "Type: \(product?.type ?? "")"
        productPrice.text = "Price: $\(product?.price ?? "0")"
    }
}
