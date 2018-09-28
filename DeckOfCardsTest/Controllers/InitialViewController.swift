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

        initView()

        setupViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func initView() {
        view.backgroundColor = UIColor.white
        navigationItem.title = "Deck of Cards"
        setupTableView()
    }
    private func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        guard tableView != nil else { return }
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.Identifier)
        view = tableView
    }

    func setupViewModel() {
        DataService.shared.fetchFullDeck { [weak self] (deck, error) in
            if let deck = deck {
                DispatchQueue.main.async {
                    self?.deckViewModel = DeckViewModel(deck: deck)
                    self?.tableView.delegate = self
                    self?.tableView.dataSource = self?.deckViewModel
                    self?.tableView.reloadData()
                }
            }
        }
    }

}
extension InitialViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = deckViewModel else { return }
        let cardViewModelSection = viewModel.suitSections[indexPath.section]
        let cardViewModel = cardViewModelSection.cardViewModels[indexPath.row]

        // Make sure the selected cell's delegate is the VC
        let cell = tableView.cellForRow(at: indexPath) as? CardTableViewCell
        cell?.delegate = self
        // Update card view model tap count, triggering KVO
        cardViewModel.tappedCount += 1

        // Finally present modally the PreviewVC
        let previewVC = PreviewViewController()
        previewVC.cardViewModel = cardViewModel
        let navCon = UINavigationController(rootViewController: previewVC)

        present(navCon, animated: true, completion: nil)
    }
}

extension InitialViewController: CardTableViewCellDelegate {
    func didUpdateCardViewModel(for cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .fade)
            print("Reloaded rows at: \(indexPath)")
        }
    }


}








