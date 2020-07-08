//
//  ExampleCountersCollectionViewCell.swift
//  Counters
//
//

import UIKit

class ExampleCountersCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    var data: String? {
        didSet {
            if let data = data {
                titleLabel.text = data
           }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.layer.masksToBounds = true
        titleLabel.clipsToBounds = true
    }

    public func configure(with data: String) {
        self.data = data
        titleLabel.layer.cornerRadius = 8
    }
}
