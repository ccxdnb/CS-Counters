//
//  UITableView+Extensions.swift
//  Counters
//
//  Created by nisum on 06-07-20.
//

import UIKit

extension UITableView {

    func setMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor(named: "textGray")
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 20, weight: .regular)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func clearBackground() {
        self.backgroundView = nil
    }
}
