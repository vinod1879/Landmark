//
//  ProductCell.swift
//  Landmark
//
//  Created by Vinod Vishwanath on 27/09/16.
//  Copyright © 2016 Vinod Vishwanath. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    
    static let reuseId = "ProductCell"
    
    @IBOutlet private var imageView     : UIImageView!
    @IBOutlet private var name          : UILabel!
    @IBOutlet private var about         : UILabel!
    @IBOutlet private var price         : UILabel!
    @IBOutlet private var strikeThru    : UILabel!
    
    func showProduct (product: Product) {
        
        name.text                   = product.title
        about.text                  = product.aboutItem
        price.text                  = product.price
        strikeThru.attributedText   = attributedStrikeThruTextForString(product.strikeThru)
        
        if let url = NSURL(string: product.imageSource ?? "") {
        
            let placeholder = UIImage(named: "placeholder")
            imageView.sd_setImageWithURL(url, placeholderImage: placeholder)
        }
    }
    
    private func attributedStrikeThruTextForString(string: String?) -> NSAttributedString {
        
        let attrStr     = NSMutableAttributedString(string: string ?? "")
        
        let attributes  = [  NSStrikethroughColorAttributeName: UIColor(white: 0.65, alpha: 1),
                            NSStrikethroughStyleAttributeName: NSNumber(integer:NSUnderlineStyle.StyleSingle.rawValue)
                          ]
        
        attrStr.addAttributes(attributes, range: NSMakeRange(0, attrStr.length))
        
        return attrStr
    }
}
