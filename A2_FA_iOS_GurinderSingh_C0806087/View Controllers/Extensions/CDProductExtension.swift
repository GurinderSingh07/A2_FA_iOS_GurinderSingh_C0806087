//
//  CDProductExtension.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation

extension CDProduct{
    
    // Convert CDProvider into Product
    func convertToProduct() -> Product {
        
        return Product(id: self.id ?? "error", name: self.name ?? "error", description: self.pDescription ?? "error", price: self.price ?? "error", providerName: self.providerName ?? "error")
    }
}
