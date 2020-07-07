//
//  MainActivityPlaceholderViewData.swift
//  Counting
//
//

import UIKit

/// Default Structure to construct a Main Activity Placeholder View
public struct MainActivityPlaceholderViewData {

    let title: String
    let body: NSAttributedString
    let actionButtonTitle: String

    /// Public init
    ///
    /// - Parameters:
    ///   - title: Title text
    ///   - body: Description text
    ///   - actionButtonTitle: action button title text

    public init(
        _ title: String = "",
        _ body: NSAttributedString = NSAttributedString(),
        _ actionButtonTitle: String = ""
    ) {
        self.title = title
        self.body = body
        self.actionButtonTitle = actionButtonTitle
    }
}
