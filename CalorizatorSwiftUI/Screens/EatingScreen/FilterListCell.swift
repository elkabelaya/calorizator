//
//  FilterListCell.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 12.06.2021.
//

import SwiftUI

struct FilterListCell: View {
        private(set) var product : Product
        var body: some View {
            HStack{
                Text(product.wrappedName)
                Spacer()
                Text("\(product.proteins)/\(product.fats)/\(product.carbohydrates)/\(product.calories)/")
            }
            .padding(.vertical, 5)
            .border(Color.green, width: 1)
            .background(Color.white)
            
            
            
        }
    }

struct FilterListCell_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static private var viewContext
    static var product: Product = Product(context: viewContext)
    static var previews: some View {
        FilterListCell(product: product)
    }
}
