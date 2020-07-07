//
//  MainActivityPlaceholderViewData.swift
//  Counters
//
//  Created by nisum on 01-07-20.
//

import Foundation
public struct BottomButtonsViewData {

    let actionButtonTitle: String
    let cancelButtonTitle: String


    /// Public init
    ///
    /// - Parameters:
    ///   - actionButtonTitle: Action button title text
    ///   - cancelButtonTitle: Cancel button title text

    public init(
        actionButtonTitle: String = "",
        cancelButtonTitle: String = ""
    ) {
        self.actionButtonTitle = actionButtonTitle
        self.cancelButtonTitle = cancelButtonTitle
    }
}
