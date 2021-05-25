//
//  ProductManager.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation

struct ProductManager{
    
    private let dataRepository = ProductDataRepository()
    
    func insertProducts() {
        
        dataRepository.insertProducts()
    }
    
    func getProduct(byProduct id: String) -> Product?{
        
        return dataRepository.get(byProduct: id)
    }
    
    func getAllProducts() -> [Product]?{
        
        return dataRepository.getAll()
    }
}
