//
//  CustomByttonStyle.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 13.06.2021.
//

import SwiftUI
public struct AppendButtonStyle: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.green)
            .cornerRadius(4.0)
            .foregroundColor(.white)
            .compositingGroup()
            .shadow(color: .green, radius: 3)
            .padding(8)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
    
}


struct AppendButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: {
                print("button pressed")
            }, label: {
                Text("AppendButton")
            })
            .buttonStyle(AppendButtonStyle())
            
        }

    }
}

