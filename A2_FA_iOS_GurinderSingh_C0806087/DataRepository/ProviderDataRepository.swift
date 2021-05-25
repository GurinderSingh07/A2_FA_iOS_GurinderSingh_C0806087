//
//  ProviderDataRepository.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 25/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation
import CoreData

struct ProviderDataRepository{
    
    func create(record: Provider){
        
        let cdProvider = CDProvider(context: PersistentStorage.shared.context)
        
        cdProvider.providerName = record.providerName
        
        var productSet = Set<CDProduct>()
        
        record.product?.forEach({ (product) in
            
            let cdProduct = CDProduct(context: PersistentStorage.shared.context)
            
            cdProduct.id = product.id
            cdProduct.name = product.name
            cdProduct.pDescription = product.description
            cdProduct.price = product.price
            cdProduct.providerName = product.providerName
            
            productSet.insert(cdProduct)
        })
        
        cdProvider.toProduct = productSet
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Provider]?{
        
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDProvider.self)
        
        guard records != nil && records?.count != 0 else {return nil}
        
        var results: [Provider] = []
        
        records!.forEach({ (cdProvider) in
            
            if cdProvider.toProduct?.count != 0{
                
                results.append(cdProvider.convertToProvider())
            }
            else{
                
                delete(byProvider: cdProvider.providerName!)
            }
        })
        
        return results
    }
    
    func get(byProvider name: String) -> Provider?{
        
        let result = self.getCdProvider(byProvider: name)
        
        guard result != nil else {return nil}
        
        return result!.convertToProvider()
    }
    
    func addProductToExistingProvider(provider: Provider, product: Product) {
        
        let provider = getCdProvider(byProvider: provider.providerName)
        guard provider != nil else {return}
        
        
        let cdProduct = CDProduct(context: PersistentStorage.shared.context)
        cdProduct.id = product.id
        cdProduct.name = product.name
        cdProduct.pDescription = product.description
        cdProduct.price = product.price
        cdProduct.providerName = product.providerName
        
    
        provider?.toProduct?.insert(cdProduct)
        
        PersistentStorage.shared.saveContext()
    }
    
    func move(oldProvider : String, toNew record: Product){

        // Remove from old provider
        let old = self.getCdProvider(byProvider: oldProvider)

        guard old != nil else { return }

        guard let setProducts = old?.toProduct else{ return }

        let modifiedSetProduct = setProducts.filter {

             $0.id != record.id
        }

        old?.toProduct = modifiedSetProduct

        if modifiedSetProduct.count == 0{

            delete(byProvider: oldProvider)
        }

        for product in setProducts{

            if  product.id == record.id{

                let productDataRepository = ProductDataRepository()

                productDataRepository.delete(byIdentifier: product.id!)
            }
        }

        var cdProvider = getCdProvider(byProvider: record.providerName)
        
        if cdProvider == nil{
            
            cdProvider = CDProvider(context: PersistentStorage.shared.context)
            cdProvider?.providerName = record.providerName
        }

        let cdProduct = CDProduct(context: PersistentStorage.shared.context)
        cdProduct.id = record.id
        cdProduct.name = record.name
        cdProduct.pDescription = record.description
        cdProduct.price = record.price
        cdProduct.providerName = record.providerName

        cdProvider?.toProduct?.insert(cdProduct)

        PersistentStorage.shared.saveContext()
    }
    
    func delete(byProvider name: String){
        
        let provider = getCdProvider(byProvider: name)
        guard provider != nil else {return}
        
        PersistentStorage.shared.context.delete(provider!)
        PersistentStorage.shared.saveContext()
    }
    
    private func getCdProvider(byProvider name: String) -> CDProvider?
    {
        let fetchRequest = NSFetchRequest<CDProvider>(entityName: "CDProvider")
        let fetchByName = NSPredicate(format: "providerName==%@", name as CVarArg)
        fetchRequest.predicate = fetchByName
        
        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}
        
        return result.first
    }
}
