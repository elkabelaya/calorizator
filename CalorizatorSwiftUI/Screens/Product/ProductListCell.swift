//
//  ProductListCell.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 09.06.2021.
//

import SwiftUI

struct ProductListCell: View {
    @State private(set) var viewModel : ProductViewModel
    var body: some View {
        HStack{
            Text(viewModel.name )
            Spacer()
            Text("\(viewModel.proteins)/\(viewModel.fats)/\(viewModel.carbohydrates)/\(viewModel.calories)/")
        }
    }
}

struct ProductListCell_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static private var viewContext
    static var product: Product = Product(context: viewContext)
    static var previews: some View {
        ProductListCell(viewModel: ProductViewModel(product: product, context: viewContext))
    }
}
