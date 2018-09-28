//
//  CardTableViewCell.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    static var Identifier: String {
        return String(describing: self)
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let cardImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()

    var cardViewModel: CardViewModel? {
        didSet {
            guard let cardViewModel = cardViewModel else { return }
            nameLabel.text = cardViewModel.value

            cardImageView.loadImage(urlString: cardViewModel.imageUrl)
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

        cardImageView.anchorWithInsets(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 0), size: CGSize(width: 25, height: 40))

        nameLabel.anchorWithInsets(top: topAnchor, leading: cardImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 0), size: CGSize(width: 0, height: 40))
    }
}
