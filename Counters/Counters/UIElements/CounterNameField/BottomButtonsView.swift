//
//  BottomButtonsView.swift
//  Counters
//
//

import UIKit

public class BottomButtonsView: UIView {

    @IBOutlet private weak var buttonsContainer: UIView!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var buttonContainerBottomConstraint: NSLayoutConstraint!

    var actionButtonClosure:  (() -> Void ) = {}
    var cancelButtonClosure:  (() -> Void ) = {}

    private let animationConstant: CGFloat = 200

    private var data: BottomButtonsViewData? {
        didSet {
            setupUI()
        }
    }

    public func configure(_ data: BottomButtonsViewData) {
        self.data = data
        cancelButton.setTitle(data.cancelButtonTitle, for: .normal)
        actionButton.setTitle(data.actionButtonTitle, for: .normal)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        alpha = 0
        buttonContainerBottomConstraint.constant = animationConstant

    }

    private func setupUI () {

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate,
          let window = sceneDelegate.window else { return }

        frame = window.frame

        window.addSubview(self)
        

        actionButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        actionButton.tintColor = .red
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)

        cancelButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        cancelButton.tintColor = UIColor(named: "MainOrange")
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
    }
    
    @objc
    func actionButtonPressed() {
        actionButtonClosure()
    }

    @objc
    func cancelButtonPressed() {
        hide()
        cancelButtonClosure()
    }

    public func hide() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut)
        {
            self.buttonContainerBottomConstraint.constant = self.animationConstant
            self.layoutIfNeeded()
        } completion: { (ended) in
            UIView.animate(
                withDuration: 1,
                animations: {
                    self.alpha = 0
                    self.removeFromSuperview()
                }
            )
        }
    }

    public func show() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut)
        {
            self.alpha = 1
        } completion: { (ended) in
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 1.0,
                initialSpringVelocity: 1.0,
                options: .curveEaseInOut,
                animations: {
                    self.buttonContainerBottomConstraint.constant = 0
                    self.layoutIfNeeded()
                }
            )
        }
    }
}
