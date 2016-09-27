//
//  Utility.swift
//  Landmark
//
//  Created by Vinod Vishwanath on 28/09/16.
//  Copyright © 2016 Vinod Vishwanath. All rights reserved.
//

import Foundation

class Utility: NSObject {
   
    static func randomNumberInRange(range: Int) -> Int {
        
        let random = Int(arc4random_uniform(UInt32(range)))
        
        return random
    }
}
