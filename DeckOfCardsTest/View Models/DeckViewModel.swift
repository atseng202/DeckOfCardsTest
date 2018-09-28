//
//  DeckViewModel.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import Foundation
import UIKit

class CardViewModelSection: NSObject {
    var sectionTitle: String
    var cardViewModels: [CardViewModel]

    init(sectionTitle: String, cardViewModels: [CardViewModel]) {
        self.sectionTitle = sectionTitle
        self.cardViewModels = cardViewModels
    }
}

class DeckViewModel: NSObject {
    var suitSections: [CardViewModelSection]

    init(deck: Deck) {
        suitSections = []

        var clubs: [CardViewModel] = []
        var hearts: [CardViewModel] = []
        var spades: [CardViewModel] = []
        var diamonds: [CardViewModel] = []
        // Set-up each section
        for card in deck.cards {
            if card.suit == Deck.Constants.Clubs { clubs.append(CardViewModel(card: card)) }
            else if card.suit == Deck.Constants.Hearts { hearts.append(CardViewModel(card: card)) }
            else if card.suit == Deck.Constants.Spades { spades.append(CardViewModel(card: card)) }
            else { diamonds.append(CardViewModel(card: card)) }
        }

        // Now sort each section by rank
        clubs.sort { $0 < $1 }
        hearts.sort { $0 < $1 }
        spades.sort { $0 < $1 }
        diamonds.sort { $0 < $1 }

        suitSections.append(CardViewModelSection(sectionTitle: Deck.Constants.Clubs, cardViewModels: clubs))
        suitSections.append(CardViewModelSection(sectionTitle: Deck.Constants.Hearts, cardViewModels: hearts))
        suitSections.append(CardViewModelSection(sectionTitle: Deck.Constants.Spades, cardViewModels: spades))
        suitSections.append(CardViewModelSection(sectionTitle: Deck.Constants.Diamonds, cardViewModels: diamonds))
    }
}
