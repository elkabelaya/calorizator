//
//  ContentView.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 09.06.2021.
//

import SwiftUI
import CoreData

struct ItemsSceen: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    var  body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                }
                .onDelete(perform: deleteItems)
                
            }
            .toolbar {
                #if os(iOS)
                //EditButton()
                #endif

                
            }
            
            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    init(){
        UITableView.appearance().separatorStyle = .singleLine
        UITableViewCell.appearance().backgroundColor = .white
        UITableView.appearance().backgroundColor = .white
    }
    var body: some View {
        TabView {
            ItemsSceen()
                .tabItem{
                    Image (systemName: "cart")
                    Text("Items")
                }
            ProductListScreen()
                .tabItem{
                    Image (systemName: "cart")
                    Text("Products")
                }
            EatingScreen(context:viewContext)
                .tabItem{
                    Image (systemName: "cart")
                    Text("Eating")
                }
        }
    }

    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
