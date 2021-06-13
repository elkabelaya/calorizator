//
//  DebouncedTextField.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 11.06.2021.
//

import SwiftUI
import Combine

struct DebouncedTextField : View {
    @Binding var debouncedText : String
    @StateObject private var textObserver = TextFieldObserver()
    
    var body: some View {
    
        VStack {
            TextField("Enter Something", text: $textObserver.searchText)
        }.onReceive(textObserver.$debouncedText) { (val) in
            debouncedText = val
        }
    }
}

class TextFieldObserver : ObservableObject {
    @Published var debouncedText = ""
    @Published var searchText = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { t in
                self.debouncedText = t
            } )
            .store(in: &subscriptions)
    }
}


struct DebouncedTextField_Previews: PreviewProvider {
    @State static var text:String = "text"
    static var previews: some View {
        VStack {
            DebouncedTextField(debouncedText: $text)
            TextField("Key", text: $text)
        }
    }
}
