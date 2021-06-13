//
//  NavBarCloseButton.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 10.06.2021.
//

import SwiftUI

struct NavBarCloseButton: View {
    let title: String
    let presentationMode: Binding<PresentationMode>
    let action: (()-> Void)?
    
    var body: some View {
        Text(title)
            .onTapGesture {
                if let _ = action {
                    action!()
                }
                presentationMode.wrappedValue.dismiss()
            }
    }
}

struct NavBarCloseButton_Previews: PreviewProvider {
    @Environment(\.presentationMode) static  private var presentationMode
    static var previews: some View {
        NavBarCloseButton(title: "ButtonTitle",
                          presentationMode: presentationMode,
                          action: {print("action happened")}
        )
    }
}
