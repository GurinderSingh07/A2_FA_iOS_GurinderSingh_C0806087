//
//  ProductDataRepository.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation
import CoreData


struct ProductDataRepository{
    
    func insertProducts(){
        
        let productData = ProductData().dataOfProducts()
        
        for product in productData{
            
            let cdProduct = CDProduct(context: PersistentStorage.shared.context)
            
            cdProduct.id = product.id
            cdProduct.name = product.name
            cdProduct.pDescription = product.description
            cdProduct.price = product.price
            cdProduct.provider = product.provider
            
            PersistentStorage.shared.saveContext()
        }
    }
    
    func getAll() -> [Product]?{
        
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDProduct.self)
        guard records != nil && records?.count != 0 else {return nil}

        var results: [Product] = []
        
        records!.forEach({ (cdProduct) in
            
            results.append(cdProduct.convertToProduct())
        })

        return results
    }
    
    func get(byProduct id: String) -> Product?{
        
        let result = self.getCdProduct(byProductId: id)
        
        guard result != nil else {return nil}
        
        return result!.convertToProduct()
    }
    
    private func getCdProduct(byProductId id: String) -> CDProduct?
    {
        let fetchRequest = NSFetchRequest<CDProduct>(entityName: "CDProduct")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById
        
        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}
        
        return result.first
    }
}
