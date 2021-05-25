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
    
    private let providerDataRepository = ProviderDataRepository()
    
    func create(record: Product){
        
        let cdProduct = CDProduct(context: PersistentStorage.shared.context)
        
        cdProduct.id = record.id
        cdProduct.name = record.name
        cdProduct.pDescription = record.description
        cdProduct.price = record.price
        cdProduct.providerName = record.providerName
        
        PersistentStorage.shared.saveContext()
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
    
    func updateProduct(record: Product){
        
        let product = getCdProduct(byProductId: record.id)
        
        guard product != nil else {return}
        
        product?.id = record.id
        product?.name = record.name
        product?.pDescription = record.description
        product?.price = record.price
        
        if product?.providerName != record.providerName{
            
            providerDataRepository.move(oldProvider: (product?.providerName)!, toNew: record)
        }
        else{
            
            product?.providerName = record.providerName
            PersistentStorage.shared.saveContext()
        }
    }
    
    func delete(byIdentifier id: String){
        
        let product = getCdProduct(byProductId: id)
        guard product != nil else {return}
        
        PersistentStorage.shared.context.delete(product!)
        PersistentStorage.shared.saveContext()
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
