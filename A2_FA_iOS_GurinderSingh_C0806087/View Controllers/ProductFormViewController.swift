//
//  ProductFormViewController.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

protocol ListViewDelegate {
    
    func getDetails()
}

class ProductFormViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfProductId: UITextField!
    @IBOutlet weak var tfProvider: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tvDescription: UITextView!
    
    
    @IBOutlet weak var btnSaveUpdate: UIButton!
    
    
    //MARK:- MemberVariables
    private let providerManager = ProviderManager() // Create provider manager to get access of provider database.
    
    private let productManager = ProductManager() // Create provider manager to get access of product database.
    
    var id = "" // Create id to get the particular product from previous screen.
    
    var isUpdate = false // Create bool to check whether we update the product or not.
    
    var delegate: ListViewDelegate? // Create delegate to fetch providers and products from the database in the previous screen.
    
    var tapGesture = UITapGestureRecognizer() // Create tap gesture
    
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupInitails()
    }
    
    
    //MARK:- PrivateFunctions
    private func setupInitails(){
        
        // Set description View's property.
        tvDescription.layer.borderWidth = 1
        tvDescription.layer.cornerRadius = 5
        tvDescription.layer.borderColor = UIColor(displayP3Red: 176/256, green: 176/256, blue: 176/256, alpha: 1).cgColor
        
        // Check whether product form open for updation or not
        if isUpdate{
            
            tvDescription.textColor = UIColor.black
            
            let product = productManager.getProduct(byProduct: id) // Get product from database and fill all the information in the product form.
            
            tfName.text = product?.name
            tfProductId.text = product?.id
            tfPrice.text = product?.price
            tvDescription.text = product?.description
            tfProvider.text = product?.providerName.capitalizingFirstLetter()
            
            btnSaveUpdate.setTitle("Update", for: .normal)
        }
        
        // set up tap gesture
        setupTapGesture()
    }
    
    private func setupTapGesture(){
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(resignKeyboard)) // Create gesture recognizer
        
        tapGesture.numberOfTapsRequired = 1 // Number of taps required to invoke gesture recognizer
        
        self.view.addGestureRecognizer(tapGesture) // Finally add tap gesture in the main view
    }
    
    @objc func resignKeyboard(gesture: UITapGestureRecognizer){
        
        self.view.endEditing(true)
    }
    
    private func checkValidation() -> Bool{
        
        if tfName.text == ""{
            
            displayAlert(alertMessage: "Please add product name.")
        }
        else if tfProductId.text == ""{
            
            displayAlert(alertMessage: "Please add product id.")
        }
        else if tfProvider.text == ""{
            
            displayAlert(alertMessage: "Please add provider name.")
        }
        else if tfPrice.text == ""{
            
            displayAlert(alertMessage: "Please add price.")
        }
        else if tvDescription.text == "description"{
            
            displayAlert(alertMessage: "Please add some description about the product.")
        }
        else{
            
            return true
        }
        
        return false
    }
    
    private func displayAlert(alertMessage: String)
    {
        let errorAlert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
    
    private func displayAlertWithAction(alertMessage: String){
        
        let errorAlert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default){ (action) in
            
            self.dismiss(animated: true) {
                
                self.delegate?.getDetails() // Trigger delegate.
            }
        }
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
    
    private func isProductIdCreated(id: String) -> Bool{
        
        guard let products = productManager.getAllProducts() else { return false}
        
        for product in products{
            
            return product.id == id
        }
        
        return false
    }
    
    //MARK:- UIButtons
    @IBAction func tapCancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSave(_ sender: Any) {
        
        if checkValidation(){
            
            let providerName = tfProvider.text?.capitalizingFirstLetter() // Always store provider with first letter capital.
            
            let product = Product(id: tfProductId.text!, name: tfName.text!.capitalizingFirstLetter(), description: tvDescription.text, price: tfPrice.text!, providerName: providerName!) // Get all the information of producat after filling the form.
            
            if isUpdate{
                
                productManager.updateProduct(record: product) // Call this function to get the product updated.
                
                displayAlertWithAction(alertMessage: "Product Updated successfully.")
            }
            else{
                
                // Check whether id is existed in database or not
                if !isProductIdCreated(id: tfProductId.text!){
                    
                    // Enter this case when new product is added and also check whether product's provider is existing or not.
                    if let getProvider = providerManager.getProvider(byProvider: providerName!){
                        
                        providerManager.addProductToExistingProvider(provider: getProvider, product: product)
                    }
                    else{
                        
                        // Create new product while new provider is created.
                        let provider = Provider(providerName: providerName!, product: [product])
                        
                        providerManager.create(record: provider)
                    }
                    
                    displayAlertWithAction(alertMessage: "New product created successfully.")
                }
                else{
                    
                    displayAlert(alertMessage: "Id is existed already. Please try with new id.")
                }
            }
        }
    }
}

extension ProductFormViewController: UITextViewDelegate{
    
    // Call this delegate method to hide description text in the text view, because initially use this text as placeholder in text view.
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "description"{
            
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}

extension ProductFormViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == tfName{
            
            tfProductId.becomeFirstResponder()
        }
        else if textField == tfProductId{
            
            tfProvider.becomeFirstResponder()
        }
        else if textField == tfProvider{
            
            tfPrice.becomeFirstResponder()
        }
        else if textField == tfPrice{
            
            tfPrice.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // Disable product id text field as product id can't be changed once created.
        if isUpdate{
            
            if textField == tfProductId{
                
                return false
            }
        }
        
        return true
    }
}
