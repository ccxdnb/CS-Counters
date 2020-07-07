//
//  UIView+Extensions.swift
//  Counting
//
//  Created by nisum on 27-06-20.
//

import UIKit

extension UIView {

    // Inspectable Corner Radius
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    /// bindEdgesToSuperView - Add constraint to all edges of the super view
    func bindEdgesToSuperView() {
        guard let superView = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
    }
}
