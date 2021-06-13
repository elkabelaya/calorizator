//
//  EatingsViewModel.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 13.06.2021.
//

import Combine
import CoreData

public class EatingsViewModel: NSObject, NSFetchedResultsControllerDelegate, ObservableObject  {
    private var eatings:[Eating] = []
    @Published var eatingGroups: [[Eating]] = .init()
    private var offset: Int = 7
    private let context: NSManagedObjectContext
    var subscription: Set<AnyCancellable> = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
       
        super.init()
    }
    
    func selectEatings(){
        let fetchController: NSFetchedResultsController<Eating> = createEatingsFetcher()
        //fetchController.fetchRequest.predicate = NSPredicate(format: "name BEGINSWITH[c] %@", filter)
        try? fetchController.performFetch()
        eatingGroups.append(contentsOf: updateGroups( fetchController.fetchedObjects ?? []))
        

    }

    private func createEatingsFetcher() -> NSFetchedResultsController<Eating> {
        let fetchRequest:NSFetchRequest<Eating> = .init(entityName: "Eating")
        fetchRequest.sortDescriptors = []
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    private func updateGroups(_ result : [Eating])-> [[Eating]]{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return  Dictionary(grouping: result){ (element : Eating)  in
            formatter.string(from: element.date!)
        }.values.map{$0}
      }
    
}
