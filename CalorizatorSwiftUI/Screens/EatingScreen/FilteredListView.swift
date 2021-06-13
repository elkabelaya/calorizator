//
//  FilteredListView.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 11.06.2021.
//

import SwiftUI

struct FilteredListView: View {
    @ObservedObject private(set) var viewModel: EatingViewModel
    @State private var productName: String = ""
    
    var body: some View {

            VStack {
                //DebouncedTextField( debouncedText: $viewModel.productName)
                TextField("Введите название", text: $viewModel.productName)
                    .foregroundColor(viewModel.selected ? .green : .red)
                ZStack {
                    if let products = viewModel.products {
                        VStack{
                            ForEach(products) { product in
                                FilterListCell(product: product)
                                .onTapGesture {
                                    viewModel.select(product: product)
                                }
                                
                            }
                            Spacer()
                                
                        }
                        .zIndex(100)
                        .padding(10)
                        
                        
                        
                    }
                    VStack {
                        NumberTextField(titleKey: "Вес в граммах", value: $viewModel.productWeight)
                        Spacer()
                    }
                }
                
            }
            
        }
    
}

struct FilteredListView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static private var viewContext
    static var previews: some View {
        FilteredListView(viewModel: EatingViewModel(context: viewContext))
    }
}
