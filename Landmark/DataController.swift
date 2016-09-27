//
//  DataController.swift
//  Landmark
//
//  Created by Vinod Vishwanath on 26/09/16.
//  Copyright © 2016 Vinod Vishwanath. All rights reserved.
//

import UIKit
import Alamofire
import HTMLReader

/*

    Class to make HTTP Requests and Parse Products
*/

class DataController: NSObject {
    
    var parsedProducts : [Product]?
    
    func fetchData (completion:(NSError?) -> Void) {
     
        Alamofire.request(.GET, Config.HostURLString)
        .responseString { responseString in
            
            self.validateResponse(responseString, completion: completion)
        }
    }
    
    private func validateResponse (response: Response<String, NSError>, completion:(NSError?) -> Void) {
     
        if let error = response.result.error {
            
            completion(error)
            return
        }
        
        guard let htmlString = response.result.value else {
            
            let error = Error.errorWithCode(.StringSerializationFailed, failureReason: "No HTML Response")
            completion(error)
            return
        }
        
        let document = HTMLDocument(string: htmlString)
        
        let carousels = document.nodesMatchingSelector(Landmark.Classes.carousel)
        
        if carousels.count > 0 {
            
            let carousel = carousels[Utility.randomNumberInRange(carousels.count)] // Select random carousel
            parseCarouselElement(carousel)
        }
        
        completion(nil)
    }
    
    private func parseCarouselElement(carousel: HTMLElement) {
        
        let li = carousel.nodesMatchingSelector(Landmark.Classes.product)
        
        var products = [Product]()
        
        for item in li {
            
            var product = Product()
            
            if let image = item.firstNodeMatchingSelector(Landmark.Tags.image) {
                
                product.imageSource = image.attributes[Landmark.Attributes.source]
            }
            
            let titleAnchors = item.nodesMatchingSelector(Landmark.Classes.productTitle)
            
            if titleAnchors.count > 0 {
                
                product.title = titleAnchors[0].innerHTML.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            }
            
            if titleAnchors.count > 1 {
                
                product.aboutItem = titleAnchors[1].innerHTML
            }
            
            if let priceSection = item.firstNodeMatchingSelector(Landmark.Tags.priceSection) {
                
                if let priceText = priceSection.firstNodeMatchingSelector(Landmark.Tags.sellingPrice)?.innerHTML {
                    
                    product.price = priceText.stringByReplacingOccurrencesOfString("&nbsp;", withString: " ")
                }
                
                if let strikeThruText = priceSection.firstNodeMatchingSelector(Landmark.Tags.strikeThru)?.innerHTML {
                    
                    product.strikeThru = strikeThruText.stringByReplacingOccurrencesOfString("&nbsp;", withString: " ")
                }
            }
            
            products.append(product)
        }
        
        parsedProducts = products
        print(li.count)
    }
}

/*

    Struct to list elements in the HTML we're interested in

*/

struct Landmark {
    
    struct Classes {
        
        static let carousel         = ".products-carousel"
        static let product          = ".product-item"
        static let productTitle     = ".title"
    }
    
    struct Tags {
        
        static let image            = "img"
        static let priceSection     = "strong"
        static let sellingPrice     = "span"
        static let strikeThru       = "del"
    }
    
    struct Attributes {
    
        static let source           = "src"
    }
}
