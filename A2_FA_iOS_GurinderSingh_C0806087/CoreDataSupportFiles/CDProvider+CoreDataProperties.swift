//
//  CDProvider+CoreDataProperties.swift
//  A2_FA_iOS_GurinderSingh_C0806087
//
//  Created by Gurinder Singh on 25/05/21.
//  Copyright © 2021 Gurinder Singh. All rights reserved.
//
//

import Foundation
import CoreData


extension CDProvider {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProvider> {
        return NSFetchRequest<CDProvider>(entityName: "CDProvider")
    }

    @NSManaged public var providerName: String?
    @NSManaged public var toProduct: Set<CDProduct>?

}

// MARK: Generated accessors for toProduct
extension CDProvider {

    @objc(addToProductObject:)
    @NSManaged public func addToToProduct(_ value: CDProduct)

    @objc(removeToProductObject:)
    @NSManaged public func removeFromToProduct(_ value: CDProduct)

    @objc(addToProduct:)
    @NSManaged public func addToToProduct(_ values: Set<CDProduct>)

    @objc(removeToProduct:)
    @NSManaged public func removeFromToProduct(_ values: Set<CDProduct>)
}
