//
//  NavigationLazyView.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 10.06.2021.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct NavigationLazyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLazyView( Text("test"))
    }
}
