//
//  BottomButtonsView.swift
//  Counters
//
//

import UIKit

/// Custom intializer for Bottom Buttons View
public enum BottomButtons {

    static func loadView() -> BottomButtonsView {
        let bundle = Bundle.main
        guard let view = bundle.loadNibNamed(
            String(describing: BottomButtonsView.self),
            owner: nil,
            options: nil
            )?.first as? BottomButtonsView else {
                return BottomButtonsView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        }
        return view
    }

    /// Create banner with data
    ///
    /// - Parameter data: Struct with Title and Body
    /// - Returns: Dynamic Pricing banner view
    public static func initWith(_ data: BottomButtonsViewData) -> BottomButtonsView {
        let view = loadView()
        view.configure(data)
        return view
    }
}
