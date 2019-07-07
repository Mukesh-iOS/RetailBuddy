//
//  RBCartCell.swift
//  Retail Buddy
//
//  Created by Mukesh on 07/07/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import UIKit

class RBCartCell: UITableViewCell {
    
    @IBOutlet weak var productPic: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var removeProductBtn: UIButton!
    
    func setDataFor(product: Product?) {
        productPic.image = UIImage.init(named: product?.category?.capitalizingFirstLetter() ?? "")
        productTitle.text = product?.title
        productType.text = "Type: \(product?.type ?? "")"
        let totalPrice = Double(product?.price ?? "0")! * Double(product?.productCount ?? 0)
        productPrice.text = "Price: $\(product?.price ?? "0") X \(product?.productCount ?? 0) = $\(totalPrice.format(f: ".2"))"
    }
}
