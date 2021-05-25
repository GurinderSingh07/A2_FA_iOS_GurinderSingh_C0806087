//
//  Provider.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 25/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation

import Foundation

class Provider{
    
    let providerName: String
    var product : [Product]?
    
    init(providerName: String, product: [Product]?) {
        
        self.providerName = providerName
        self.product = product
    }
}
