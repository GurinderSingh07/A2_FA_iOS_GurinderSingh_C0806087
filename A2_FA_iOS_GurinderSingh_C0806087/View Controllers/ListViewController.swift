//
//  ListViewController.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tbList: UITableView!
    
    //MARK:- MemberVariables
    let productManager = ProductManager() // Create provider manager to access database of product.
    
    var arrProducts = [Product]() // Create array to store all the products from the database.
    
    let searchController = UISearchController(searchResultsController: nil) // Create search controller for search operation.
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupInitails()
    }
    
    //MARK:- PrivateFunctions
    func setupInitails(){
        
        self.title = "Products" // Set up Navigation bar title.
        
         // Set up large title attributes.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 40) ??
                UIFont.systemFont(ofSize: 40)]
        
        // Set up small title attributes.
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 20) ??
           UIFont.systemFont(ofSize: 20)]
        
        getDatabaseData() // Get data from the database.
        
        searchBarSetup() // Set up search bar below the navigation bar.
        
        tbList.tableFooterView = UIView()
    }
    
    func getDatabaseData(){
        
        // Access all the products from the database.
        guard let products = productManager.getAllProducts() else{ return }
        arrProducts = products
        
        // Reload the table view to get fresh data.
        tbList.reloadData()
        
        // Get the first product from array of product to display the first product information
        let product = products[0]
        
        let productId = product.id
        
        showProductForm(id: productId)
    }
    
    func showProductForm(id: String){
        
        // Navigate to product form
        let productForm = self.storyboard!.instantiateViewController(withIdentifier: "ProductFormViewController") as! ProductFormViewController
        
        productForm.id = id
        
        self.navigationController?.present(productForm, animated: true, completion: nil)
    }
    
    private func searchBarSetup(){
        
        // Set up search controller basic properties.
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Items"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension ListViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrProducts.count // Create number of rows according to the products count.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell", for: indexPath) as! ListTableCell
        
        // Access the product according to the indexing of array
        let product = arrProducts[indexPath.row]
        
        // show product data on the table view cell
        cell.lblTitle.text = product.name
        cell.lblSubtitle.text = product.provider
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         // when product is shown and tap on the product then you will navigate and get the product information
        let product = arrProducts[indexPath.row]
        
        let productId = product.id
        
        showProductForm(id: productId)
    }
}

extension ListViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        
        guard let products = productManager.getAllProducts() else{ return }
        
        // When search text is empty then you will get the whole product array.
        if searchText == ""{
            
            arrProducts = products
        }
        else{
            
            // Filter array according to the search text.
            arrProducts = products
    
            arrProducts = arrProducts.filter{
                 
                $0.name.contains(searchText)
            }
        }
        
         tbList.reloadData()
    }
}
