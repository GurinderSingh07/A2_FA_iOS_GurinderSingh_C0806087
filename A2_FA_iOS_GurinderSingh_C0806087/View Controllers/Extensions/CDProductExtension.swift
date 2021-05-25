//
//  CDProductExtension.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation

extension CDProduct{
    
    func convertToProduct() -> Product {
        
        return Product(id: self.id ?? "Error", name: self.name ?? "Error", description: self.pDescription ?? "Error", price: self.price ?? "Error", provider: self.provider ?? "Error")
    }
}
