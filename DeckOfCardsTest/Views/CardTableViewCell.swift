//
//  CardTableViewCell.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import UIKit

protocol CardTableViewCellDelegate: class {
    func didUpdateCardViewModel(for cell: UITableViewCell)
}

class CardTableViewCell: UITableViewCell {

    static var Identifier: String {
        return String(describing: self)
    }

    weak var delegate: CardTableViewCellDelegate?
    
    private var token: NSKeyValueObservation?

    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let cardImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()

    let tapCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    // MARK: - KVO Example Implementation
    var cardViewModel: CardViewModel? {
        willSet {
            token?.invalidate()
        }
        didSet {
            guard let cardViewModel = cardViewModel else { return }
            nameLabel.text = cardViewModel.value
            cardImageView.loadImage(urlString: cardViewModel.imageUrl)
            tapCountLabel.text = "\(cardViewModel.tappedCount) Click(s)"
            // Set up observer here
            token = cardViewModel.observe(\CardViewModel.tappedCount, changeHandler: { [weak self] (object, change) in
                if let cell = self {
                    cell.delegate?.didUpdateCardViewModel(for: cell)
                }
            })
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCardView()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCardView() {
        addSubview(nameLabel)
        addSubview(cardImageView)
        addSubview(tapCountLabel)
        let safeArea = safeAreaLayoutGuide

        cardImageView.anchorWithInsets(top: safeArea.topAnchor, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 0), size: CGSize(width: 25, height: 40))

        nameLabel.anchorWithInsets(top: safeArea.topAnchor, leading: cardImageView.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 0), size: CGSize(width: 60, height: 40))

        tapCountLabel.anchorWithInsets(top: safeArea.topAnchor, leading: nil, bottom: nil, trailing: safeArea.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8), size: CGSize(width: 80, height: 40))
    }
}
