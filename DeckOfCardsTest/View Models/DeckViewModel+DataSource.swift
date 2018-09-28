//
//  DeckViewModel+DataSource.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import UIKit

extension DeckViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suitSections[section].cardViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cardViewModelSection = suitSections[indexPath.section]
        let cardViewModel = cardViewModelSection.cardViewModels[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.Identifier, for: indexPath) as! CardTableViewCell
        cell.cardViewModel = cardViewModel
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return suitSections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return suitSections[section].sectionTitle
    }

}


