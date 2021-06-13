//
//  EatingScreen.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 11.06.2021.
//

import SwiftUI
import CoreData

struct ExampleRow: View {
    var body: some View {
        Text("Example Row")
    }
}


struct EatingScreen: View {
    
    private var context: NSManagedObjectContext
    @State private var isFirstAppear: Bool = true
    @State private var addSelection: Int? = nil
    @ObservedObject private var viewModel:EatingsViewModel
    
    init( context: NSManagedObjectContext){
        self.context = context
        viewModel = .init(context: context)
        //viewModel.selectEatings()
    }
    var body: some View {
        //viewModel
        NavigationView{
            VStack {
                List {
                    ForEach(viewModel.eatingGroups, id: \.self) { (section: [Eating]) in
                        Section(header: Text( String(describing: section[0].date))) {
                                ForEach(section, id: \.self) { eating in
                                    Text("\(eating.weight)")
                            }
                        }
                        }.id(viewModel.eatingGroups.count)
                      }
                .listStyle(SidebarListStyle())
                .navigationTitle(Text("Today"))
                NavigationLink(destination: NavigationLazyView(EatingView()), tag: 1,selection: $addSelection){
                    Button(action: {
                        addSelection = 1
                    }, label: {
                        Text("Add eating")
                    })
                    .buttonStyle(AppendButtonStyle())
                }
            }.onAppear(){
                if (isFirstAppear){
                    self.isFirstAppear = false
                    viewModel.selectEatings()
                }
            }
        }
    }
}

struct EatingScreen_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static private var viewContext
    static var previews: some View {
        EatingScreen(context: viewContext)
    }
}
