//
//  EatingView.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 12.06.2021.
//

import SwiftUI

struct EatingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        let viewModel:EatingViewModel = .init(context:viewContext)
        ClosableVStack(action: {viewModel.addEating()}){
            Text("Я сейчас съем")
            Text("Название")
            
            FilteredListView(viewModel:viewModel)
            
        }
    }
}

struct EatingView_Previews: PreviewProvider {
    static var previews: some View {
        EatingView()
    }
}
