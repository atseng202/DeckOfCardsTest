//
//  PreviewViewController.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    var cardViewModel: CardViewModel! {
        didSet {
            fullImageView.loadImage(urlString: cardViewModel.imageUrl)
        }
    }

    let fullImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        setupViews()

        navigationItem.title = "\(cardViewModel.value) of \(cardViewModel.suit)"

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss(sender:)))
    }

    // MARK: - Action Methods
    @objc func handleDismiss(sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    // MARK: - View Setup
    private func setupViews() {
        view.addSubview(fullImageView)
        let safeArea = view.safeAreaLayoutGuide
        fullImageView.anchorWithInsets(top: safeArea.topAnchor, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: safeArea.trailingAnchor)
    }
}
