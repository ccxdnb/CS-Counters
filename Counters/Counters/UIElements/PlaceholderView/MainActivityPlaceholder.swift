//
//  MainActivityPlaceholder.swift
//  Counting
//
//

import UIKit

/// Custom intializer for Main Activity Placeholder
public enum MainActivityPlaceholder {

    static func loadView() -> MainActivityPlaceholderView {
        let bundle = Bundle.main
        guard let view = bundle.loadNibNamed(
            String(describing: MainActivityPlaceholderView.self),
            owner: nil,
            options: nil
            )?.first as? MainActivityPlaceholderView else {
                return MainActivityPlaceholderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        }
        return view
    }

    /// Create banner with data
    ///
    /// - Parameter data: Struct with Title and Body
    /// - Returns: Dynamic Pricing banner view
    public static func initWith(_ data: MainActivityPlaceholderViewData) -> MainActivityPlaceholderView {
        let view = loadView()
        view.configure(data)
        return view
    }
}
