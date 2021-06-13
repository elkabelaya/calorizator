//
//  EatingViewModel.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 12.06.2021.
//

import SwiftUI
import Combine
import CoreData

public class EatingViewModel: NSObject, NSFetchedResultsControllerDelegate, ObservableObject  {
    
    var subscription: Set<AnyCancellable> = []
    private let context: NSManagedObjectContext
    var product: Product?
    @Published var products: [Product]?
    @Published var productName: String = ""
    @Published var productWeight: String = ""
    @Published var selected: Bool = false
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
        initDebounce()

    }
    
    
    func select(product:Product){
        selected = true
        self.product = product
        self.productName = product.wrappedName
        products = nil
    }
    
    func addEating(){
        let newItem:Eating = Eating(context: context)
        newItem.date = Date()
        newItem.weight = productWeight.toInt16()
        newItem.product = self.product

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func initDebounce(){
        $productName
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap{ $0 }
            .sink { (_) in
            } receiveValue: { [self] (productName) in
                if (product != nil && productName == product!.wrappedName){
                    return
                }
                updateFilter(filter: productName)
            }.store(in: &subscription)
    }
    
    private func updateFilter(filter:String){
        product = nil
        selected = false
        if (filter.count > 0){
            let fetchController: NSFetchedResultsController<Product> = createProductFetcher()
            fetchController.fetchRequest.predicate = NSPredicate(format: "name BEGINSWITH[c] %@", filter)
            try? fetchController.performFetch()
            products = fetchController.fetchedObjects
        } else {
            products = nil
        }

    }
    
    private func createProductFetcher() -> NSFetchedResultsController<Product> {
        let fetchRequest:NSFetchRequest<Product> = .init(entityName: "Product")
        fetchRequest.sortDescriptors = []
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    
}

