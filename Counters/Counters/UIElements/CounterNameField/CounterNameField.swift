//
//  CounterNameField.swift
//  Counters
//
//  Created by nisum on 30-06-20.
//
import UIKit

class CounterNameField: UITextField {

    private let padding = UIEdgeInsets(top: 17, left: 17, bottom: 18, right: 5)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: padding)
     }

     override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: padding)
     }

     override open func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: padding)
     }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: (bounds.size.width/2) - 25, y: bounds.origin.y), size: bounds.size)
    }

    required init(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)!
         self.commonInit()
     }

     override init(frame: CGRect = CGRect(x: 0, y: 0, width: 351, height: 56)) {
         super.init(frame: frame)
         self.commonInit()
     }

     private func commonInit(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .white
        textColor = .black
        placeholder = "Cups of coffee"
        heightAnchor.constraint(equalToConstant: 56).isActive = true
        activityIndicator.frame.origin.x -= 10

        rightView = activityIndicator
        rightViewMode = .always;

        font = .systemFont(ofSize: 17, weight: .regular)
     }

    func startLoading () {
        activityIndicator.startAnimating()
    }

    func stopLoading () {
        activityIndicator.stopAnimating()
    }
}
