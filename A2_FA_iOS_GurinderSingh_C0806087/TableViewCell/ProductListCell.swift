//
//  ProductListCell.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 25/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var lblProductTitle: UILabel!
    
    //MARK:- Cell Funcitons
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
