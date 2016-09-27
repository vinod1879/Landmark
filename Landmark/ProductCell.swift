//
//  ProductCell.swift
//  Landmark
//
//  Created by Vinod Vishwanath on 27/09/16.
//  Copyright © 2016 Vinod Vishwanath. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let reuseId = "ProductCell"
    
    @IBOutlet private var imageView     : UIImageView!
    @IBOutlet private var name          : UILabel!
    @IBOutlet private var about         : UILabel!
    @IBOutlet private var price         : UILabel!
    @IBOutlet private var strikeThru    : UILabel!
    
    func showProduct (product: Product) {
        
        name.text            = product.title
        about.text           = product.aboutItem
        price.text           = product.price
        strikeThru.text      = product.strikeThru
    }
}
