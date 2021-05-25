//
//  CDProviderExtension.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 25/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation

extension CDProvider{
    
    // Convert CD provider into Provider to access all the data in modular form
    func convertToProvider() -> Provider
    {
        return Provider(providerName: self.providerName ?? "error", product: self.convertToProducts())
    }

    // Convert all the CDProducts into array of product.
    private func convertToProducts() -> [Product]?
    {
        guard self.toProduct != nil && self.toProduct?.count != 0 else {return nil}

        var products: [Product] = []

        self.toProduct?.forEach({ (cdProduct) in
            
            products.append(cdProduct.convertToProduct())
        })

        return products
    }
}
