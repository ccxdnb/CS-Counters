//
//  ExampleCountersTableViewCell.swift
//  Counters
//
//

import UIKit

class ExampleCountersTableViewCell:
    UITableViewCell,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    var data: [String]? {
        didSet {
            if let data = data {
                setupCells(with: data)
                layoutIfNeeded()
            }
        }
    }
    var cells = [ExampleCountersCollectionViewCell]()

    weak var delegate: CounterTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }


    public func configure(with data: [String]) {
        self.data = data
    }

    private func setupUI() {

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        collectionView.autoresizingMask = .flexibleWidth;

        let bundle = Bundle(for: ExampleCountersTableViewCell.self)

        let cell = UINib(nibName: "ExampleCountersCollectionViewCell", bundle: bundle)
        collectionView.register(cell, forCellWithReuseIdentifier: "ExampleCountersCollectionViewCell")
    }

    private func setupCells(with examples: [String]) {
        cells = []
        for (index, data) in examples.enumerated() {
            let abstractCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCountersCollectionViewCell", for: IndexPath(row: index, section: 0))
            if let cell = abstractCell as? ExampleCountersCollectionViewCell {
                cell.configure(with: data)
                cells.append(cell)
            }
        }
        collectionView.reloadData()
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cells[indexPath.row]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let label = UILabel(frame: CGRect.zero)
            label.text = data![indexPath.item]
            label.clipsToBounds = true
            label.layer.masksToBounds = true
            label.sizeToFit()

        return CGSize(width: label.frame.width + 30, height: 55)
    }
}
