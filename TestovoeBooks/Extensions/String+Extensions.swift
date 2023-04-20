//
//  String+Extensions.swift
//  TestovoeBooks
//
//  Created by MacBook Air on 20.04.2023.
//

import Foundation

extension String {
    var latinCharactersOnly: Bool {
        return self.range(of: "\\P{Latin}", options: .regularExpression) == nil
    }
}
