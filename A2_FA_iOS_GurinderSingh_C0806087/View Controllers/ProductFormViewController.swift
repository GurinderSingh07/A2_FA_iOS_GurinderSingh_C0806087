//
//  ProductFormViewController.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class ProductFormViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfProductId: UITextField!
    @IBOutlet weak var tfProvider: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tvDescription: UITextView!
    
    //MARK:- MemberVariables
    var id = "" // Create id to get the particular product from previous screen.
    
    let productManager = ProductManager() // Create provider manager to get access of product database.

    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupInitails()
    }
    
    //MARK:- PrivateFunctions
    func setupInitails(){
        
        // Set description View's property.
        tvDescription.textColor = UIColor.black
        tvDescription.layer.borderWidth = 1
        tvDescription.layer.cornerRadius = 5
        tvDescription.layer.borderColor = UIColor(displayP3Red: 176/256, green: 176/256, blue: 176/256, alpha: 1).cgColor
        
        // set up product form according to the selected product.
        setupProductForm()
    }
    
    func setupProductForm(){
        
        // Get product from database and fill all the information in the product form.
        let product = productManager.getProduct(byProduct: id)
        
        tfName.text = product?.name
        tfProductId.text = product?.id
        tfPrice.text = product?.price
        tvDescription.text = product?.description
        tfProvider.text = product?.provider
    }
    
    //MARK:- UIButtons
    @IBAction func tapCancel(_ sender: Any) {
        
        // To dismiss the present controller
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProductFormViewController: UITextViewDelegate,UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // To disable the text field.
        return false
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        // To disable the text view.
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        // Call this delegate method to hide description text in the text view, because initially use this text as placeholder in text view.
        if textView.text == "description"{
            
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}
