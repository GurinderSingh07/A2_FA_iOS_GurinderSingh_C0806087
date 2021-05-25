//
//  Product.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation

class Product{
    
    let id: String
    let name: String
    let description: String
    let price: String
    let providerName: String
    let provider: Provider?
    
    init(id: String, name: String, description: String, price: String, providerName: String, provider: Provider? = nil) {
        
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.providerName = providerName
        self.provider = provider
    }
}
