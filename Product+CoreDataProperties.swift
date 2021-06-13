//
//  Product+CoreDataProperties.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 11.06.2021.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var calories: Int16
    @NSManaged public var carbohydrates: Int16
    @NSManaged public var fats: Int16
    @NSManaged public var name: String?
    @NSManaged public var proteins: Int16
    
    var wrappedName: String {
        name ?? "Unknown"
    }

}

extension Product : Identifiable {

}
