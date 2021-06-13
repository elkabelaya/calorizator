//
//  ProductView.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 09.06.2021.
//

import SwiftUI

struct ProductView: View {
    @State private(set) var viewModel : ProductViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ClosableVStack(action: {viewModel.save()}){
            TextField("Название", text: $viewModel.name)

            NumberTextField(titleKey: "Белки", value: $viewModel.proteins)
            NumberTextField(titleKey: "Жиры", value: $viewModel.fats)
            NumberTextField(titleKey: "Углеводы", value: $viewModel.carbohydrates)
            NumberTextField(titleKey: "Калории", value: $viewModel.calories)
        }
        
        
    }
}

struct ProductView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static private var viewContext
    static var product: Product = Product(context: viewContext)
    static var previews: some View {
        ProductView(viewModel: ProductViewModel(product: product, context: viewContext))
    }
 }
