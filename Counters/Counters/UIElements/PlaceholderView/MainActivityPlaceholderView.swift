//
//  PlaceholderView.swift
//  Counting
//
//

import UIKit

public class MainActivityPlaceholderView: UIView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!

    public var actionButtonClosure: (() -> Void ) = {}

    public func configure(_ data: MainActivityPlaceholderViewData) {
        setupUI(data)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }

    private func setupUI (_ data: MainActivityPlaceholderViewData) {
        titleLabel.text = data.title
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)

        bodyLabel.attributedText = data.body
        bodyLabel.font = .systemFont(ofSize: 17, weight: .regular)
        bodyLabel.textColor = UIColor(named: "textGray")
        bodyLabel.numberOfLines = 0
        bodyLabel.lineBreakMode = .byWordWrapping
        bodyLabel.textAlignment = .center

        actionButton.setTitle(data.actionButtonTitle, for: .normal)
        actionButton.setCountersConfirmationStyle()
        actionButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        actionButton.isUserInteractionEnabled = true
        actionButton.isEnabled = true
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }

    @objc
    private func actionButtonPressed () {
        self.actionButtonClosure()
    }
}
