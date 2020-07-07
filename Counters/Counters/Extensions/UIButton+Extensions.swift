//
//  UIButton+Extensions.swift
//  Counters
//
//  Created by nisum on 30-06-20.
//

import UIKit

extension UIButton {
    func setCountersConfirmationStyle() {
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = UIColor(named: "MainOrange")
        let padding = UIEdgeInsets(top: 7, left: 16, bottom: 7, right: 16)
        contentEdgeInsets = padding
        layer.cornerRadius = 8
        sizeToFit()
        titleLabel?.font = .systemFont(ofSize: 23, weight: .semibold)
    }
}
