//
//  WelcomeView.swift
//  Counters
//
//

import UIKit

class WelcomeView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    var continueButtonAction: (() -> Void) = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
    }

    @objc
    private func continueButtonPressed() {
        removeFromSuperview()
        continueButtonAction()
    }
}
