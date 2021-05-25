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
    
    func create(record: Product){
        
        dataRepository.create(record: record)
    }
    
    func getAllProducts() -> [Product]?{
        
        return dataRepository.getAll()
    }
    
    func getProduct(byProduct id: String) -> Product?{
        
        return dataRepository.get(byProduct: id)
    }
    
    func updateProduct(record: Product){
        
        dataRepository.updateProduct(record: record)
    }
    
    func deleteProduct(record: Product){
        
        dataRepository.delete(byIdentifier: record.id)
    }
}
