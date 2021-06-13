//
//  ClosableVStack.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 12.06.2021.
//

import SwiftUI
struct ClosableVStack<Content>: View where Content: View {
    @Environment(\.presentationMode) private var presentationMode
    private let action: () -> Void
    private let content:() -> Content
    
    @State private var tapped:Bool = false
    
    public init(action:@escaping () -> Void, @ViewBuilder content: @escaping () -> Content){
        self.action = action
        self.content = content
    }

    var body: some View {
        VStack{
            content()
        }
        .navigationBarItems(leading: NavBarCloseButton( title: "Готово",
                                                        presentationMode: presentationMode,
                                                        action: action
                                                      ),
                            trailing: NavBarCloseButton( title: "Отмена",
                                                         presentationMode: presentationMode,
                                                         action: nil
                                                       )
        )
        .navigationBarBackButtonHidden(true)
    }
}

struct ClosableVStack_Previews: PreviewProvider {
    static var previews: some View {
        ClosableVStack(action:{print("close")}){
            Text("Sample")
        }
    }
}
