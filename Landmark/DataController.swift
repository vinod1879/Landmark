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

private let DivElement = "div"
private let ClassAttr  = "class"

class DataController: NSObject {
    
    private var targetElement : HTMLElement?
    
    var targetElementHTMLString : String? {
        
        if let div = targetElement {
            
            return div.serializedFragment
        }
        
        return nil
    }
    
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
        
        let divElements = document.nodesMatchingSelector(DivElement)
        print(divElements.count)
        
        for div in divElements {
            
            let attr = div.attributes
            
            guard let classValue = attr[ClassAttr] else { continue }
            
            if classValue.containsString(Config.TargetClass) {
             
                targetElement = div
                
                print("Success")
                break
            }
        }
        
        completion(nil)
    }
}
