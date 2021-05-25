//
//  ProviderManager.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 25/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation

struct ProviderManager{
    
    private let dataRepository = ProviderDataRepository()
    
    func create(record: Provider){
        
        dataRepository.create(record: record)
    }
    
    func getAllProviders() -> [Provider]?{
        
        return dataRepository.getAll()
    }
    
    func addProductToExistingProvider(provider: Provider, product: Product){
        
        dataRepository.addProductToExistingProvider(provider: provider, product: product)
    }
    
    func getProvider(byProvider name: String) -> Provider?{
        
        return dataRepository.get(byProvider: name)
    }
    
    func deleteProvider(record: Provider){
        
        dataRepository.delete(byProvider: record.providerName)
    }
}
