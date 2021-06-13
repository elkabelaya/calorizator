//
//  ProductListScreen.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 09.06.2021.
//

import SwiftUI

struct ProductListScreen: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    
    var  body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(products) { product in
                        let viewModel = ProductViewModel(product: product, context: viewContext)
                        NavigationLink(destination: NavigationLazyView(ProductView(viewModel: viewModel))){
                            ProductListCell(viewModel: viewModel)
                        }
                        
                    }
                    .onDelete(perform: deleteItems)
                    
                }.navigationTitle(Text("My products"))
                
                NavigationLink(destination: NavigationLazyView(ProductView(viewModel: ProductViewModel(context: viewContext))))
                {
                    
                    Button(action: {}, label: {
                        Text("Add product")
                    })
                    .buttonStyle(AppendButtonStyle())
                    
                }
                
                
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newProduct = Product(context: viewContext)
            
            newProduct.name = "product"
            newProduct.calories = 200
            newProduct.fats = 10
            newProduct.proteins = 20
            newProduct.carbohydrates = 5
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
            offsets.map { products[$0] }.forEach(viewContext.delete)

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

#if DEBUG
struct ProductListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductListScreen()
    }
}
#endif
