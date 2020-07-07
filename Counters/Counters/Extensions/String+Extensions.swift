//
//  String+Extensions.swift
//  Counting
//
//

import Foundation

extension String {
    public var localized: String {
        NSLocalizedString(
            self,
            tableName: nil,
            bundle: Bundle.main,
            value: self,
            comment: ""
        )
    }

    public func localized(with args: CVarArg...) -> String {
        String(format: self.localized, arguments: args)
    }
}
