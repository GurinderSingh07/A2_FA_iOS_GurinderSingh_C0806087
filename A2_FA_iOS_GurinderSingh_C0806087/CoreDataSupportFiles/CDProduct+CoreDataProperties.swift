//
//  CDProduct+CoreDataProperties.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 22/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//
//

import Foundation
import CoreData

extension CDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var pDescription: String?
    @NSManaged public var price: String?
    @NSManaged public var provider: String?
}
