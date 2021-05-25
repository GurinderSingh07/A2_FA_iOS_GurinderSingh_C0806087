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
    let provider: String
    
    init(id: String, name: String, description: String, price: String, provider: String) {
        
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.provider = provider
    }
}

struct ProductData{
    
        // Set up product data
        func dataOfProducts() ->[Product]{
        
        let product = [
            
            Product(id: "1", name: "Civic", description: "Honda Civic 001", price: "$20,000", provider: "Honda"),
            Product(id: "2", name: "Accord", description: "Honda Accord 002", price: "$21,000", provider: "Honda"),
            Product(id: "3", name: "Odyssey", description: "Honda Odyssey 003", price: "$22,000", provider: "Honda"),
            Product(id: "4", name: "Passport", description: "Honda Passport 004", price: "$23,000", provider: "Honda"),
            Product(id: "5", name: "Elantra", description: "Hyundai Elantra 005", price: "$24,000", provider: "Hyundai"),
            Product(id: "6", name: "Venue", description: "Hyundai Venue 006", price: "$25,000", provider: "Hyundai"),
            Product(id: "7", name: "Kona", description: "Hyundai Kona 007", price: "$26,000", provider: "Hyundai"),
            Product(id: "8", name: "Tucson", description: "Hyundai Tucson 008", price: "$27,000", provider: "Hyundai"),
            Product(id: "9", name: "Vitara", description: "Suzuki Vitara 009", price: "$28,000", provider: "Suzuki"),
            Product(id: "10",name: "Kazashi", description: "Suzuki Kazashi 010", price: "$29,000", provider: "Suzuki"),
        ]
        
        return product
    }
}
