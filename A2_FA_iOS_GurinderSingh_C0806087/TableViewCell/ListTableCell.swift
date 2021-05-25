//
//  ListTableCell.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import UIKit

class ListTableCell: UITableViewCell {

     //MARK:- IBOutlets
       @IBOutlet weak var iconFolder: UIImageView!
       @IBOutlet weak var lblTitle: UILabel!
       @IBOutlet weak var lblSubtitle: UILabel!
       
       @IBOutlet weak var constLeadingLblTitle: NSLayoutConstraint!
       
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
