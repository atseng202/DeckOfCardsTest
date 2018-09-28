//
//  ViewController.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    var deckViewModel: DeckViewModel?

    var tableView: UITableView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.magenta
        navigationItem.title = "Deck of Cards"

        setupTableView()
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.Identifier)
        
        DataService.shared.fetchFullDeck { [weak self] (deck, error) in
            if let deck = deck {
                for card in deck.cards {
                    print("\(card.value) of \(card.suit)")
                }
                DispatchQueue.main.async {
                    self?.deckViewModel = DeckViewModel(deck: deck)
                    self?.tableView.delegate = self?.deckViewModel
                    self?.tableView.dataSource = self?.deckViewModel
                    self?.tableView.reloadData()

                    guard let self = self else { return }
                    for section in self.deckViewModel!.suitSections {
                        print("# of cards in this section: ", section.cardViewModels.count)
                    }
                }


            }
        }
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        guard tableView != nil else { return }

        view = tableView
    }
}








