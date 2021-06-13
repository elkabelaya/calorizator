//
//  CalorizatorSwiftUIApp.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 09.06.2021.
//

import SwiftUI


@main
struct CalorizatorSwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
