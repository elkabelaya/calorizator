//
//  ProductViewModel.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 11.06.2021.
//

import CoreData

class ProductViewModel {
    private(set) var product:Product? = nil
    private let context:NSManagedObjectContext
    @Published  var name: String = ""
    @Published  var calories: String = "0"
    @Published  var carbohydrates: String = "0"
    @Published  var fats: String = "0"
    @Published  var proteins: String = "0"

    init(context:NSManagedObjectContext){
        self.context = context
    }
    
    init(product:Product, context:NSManagedObjectContext){
        self.context = context
        self.product = product
        name = product.wrappedName
        calories = String(product.calories)
        carbohydrates = String(product.carbohydrates)
        fats = String(product.fats)
        proteins = String(product.proteins)
    }
    
    func save(){
        if product == nil {
            product = Product(context: context)
        }
        product!.name = name
        product!.calories = calories.toInt16()
        product!.carbohydrates = carbohydrates.toInt16()
        product!.fats = fats.toInt16()
        product!.proteins = proteins.toInt16()
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
}

