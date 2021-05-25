//
//  ProductListViewController.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 25/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var tbProductList: UITableView!
    @IBOutlet weak var lblProviderName: UILabel!
    
    
    //MARK:- MemberVariables
    var providerName = "" // Create string to get provider name from previous screen, so that able to access provider from database.
    
    var arrProductNames = [String]() // Create array to store all the products.
    
    let providerManager = ProviderManager() // Create provider manager to fetch provider from data base.
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupInitials()
    }
    
    
    //MARK:- PrivateMethods
    func setupInitials(){
        
        let provider = providerManager.getProvider(byProvider: providerName) // Fetch provider from database.
        
        guard let products = provider?.product else{ return } // Get all the products from provider.
        
        for product in products{
            
            let productName = product.name
            arrProductNames.append(productName) // Iterate products and append in the created array.
        }
        
        lblProviderName.text = provider?.providerName // Set provider name as a title at the top navigation bar.
        
        tbProductList.tableFooterView = UIView() // Remove extra seprator lines from table view.
    }
}

extension ProductListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrProductNames.count; // Get count of array so that create rows in the table.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        
        let producName = arrProductNames[indexPath.row] // Get product name according to the indexing of array.
        
        cell.lblProductTitle.text = producName // set product title in the cell.
        
        return cell
    }
}
