
import UIKit

protocol  CounterTableViewCellDelegate: AnyObject {
    func decreaseButtonPressed(counter: Counter)
    func increaseButtonPressed(counter: Counter)
}

class CounterTableViewCell: UITableViewCell {

    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var increaseButton: UIButton!
    @IBOutlet private weak var decreaseButton: UIButton!

    var cellTitle: String {
        titleLabel.text ?? ""
    }

    var data: Counter? {
        didSet {
            if let data = data {
                countLabel.text = String(data.count)
                countLabel.isEnabled = data.count != 0
                titleLabel.text = data.title
                titleLabel.sizeToFit()
                layoutIfNeeded()
            }
        }
    }

    weak var delegate: CounterTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }


    public func configure(with data: Counter) {
        self.data = data
    }

    @objc
    func decreaseButtonPressed() {
        guard let counter = data, counter.count != 0 else { return }
        delegate?.decreaseButtonPressed(counter: counter)
    }

    @objc
    func increaseButtonPressed() {
        guard let counter = data else { return }
        delegate?.increaseButtonPressed(counter: counter)
    }

    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = true
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = UIColor(named: "black")
        decreaseButton.addTarget(self, action: #selector(decreaseButtonPressed), for: .touchUpInside)
        increaseButton.addTarget(self, action: #selector(increaseButtonPressed), for: .touchUpInside)
    }
}
