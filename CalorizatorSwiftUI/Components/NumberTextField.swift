//
//  NumberTextField.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 10.06.2021.
//

import SwiftUI

struct NumberTextField: View {
    var titleKey: String = ""
    var value: Binding<String>
    var body: some View {
        HStack{
            Text(titleKey)
            
            TextField(titleKey, text: value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                
                
        }
    }
}

struct NumberTextField_Previews: PreviewProvider {
    @State static var emptyText:String = ""
    @State static var text:String = "23"
    static var previews: some View {
        VStack{
            NumberTextField(titleKey: "Enter text", value: $emptyText)
            NumberTextField(titleKey: "Enter text", value: $text)
        }

    }
}

