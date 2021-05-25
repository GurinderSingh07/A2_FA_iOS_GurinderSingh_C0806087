//
//  String+Extension.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 25/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//

import Foundation

extension String {
    
    // Create functions to make the first letter of string capital.
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
