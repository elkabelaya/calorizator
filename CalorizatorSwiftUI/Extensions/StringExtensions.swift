//
//  StringExtensions.swift
//  CalorizatorSwiftUI
//
//  Created by Elka Belaya on 10.06.2021.
//

extension String {
    func toInt16() -> Int16 {
        return Int16(self) ?? 0
    }
}

extension String: Identifiable {
    public var id: String { self }
}
