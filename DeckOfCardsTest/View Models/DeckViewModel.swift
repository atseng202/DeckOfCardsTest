//
//  DeckViewModel.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import Foundation
import UIKit

protocol CardViewModelSection {
    var sectionTitle: String { get }
    var cardViewModels: [CardViewModel] { get }
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

        suitSections.append(DeckViewModelClubCards(clubCardViewModels: clubs))
        suitSections.append(DeckViewModelHeartCards(heartCardViewModels: hearts))
        suitSections.append(DeckViewModelSpadeCards(spadeCardViewModels: spades))
        suitSections.append(DeckViewModelDiamondCards(diamondCardViewModels: diamonds))
    }
}

class DeckViewModelClubCards: CardViewModelSection {
    var sectionTitle: String { return Deck.Constants.Clubs }

    var cardViewModels: [CardViewModel]

    init(clubCardViewModels: [CardViewModel]) {
        self.cardViewModels = clubCardViewModels
    }
}

class DeckViewModelHeartCards: CardViewModelSection {
    var sectionTitle: String { return Deck.Constants.Hearts }

    var cardViewModels: [CardViewModel]

    init(heartCardViewModels: [CardViewModel]) {
        self.cardViewModels = heartCardViewModels
    }
}

class DeckViewModelSpadeCards: CardViewModelSection {
    var sectionTitle: String { return Deck.Constants.Spades }

    var cardViewModels: [CardViewModel]

    init(spadeCardViewModels: [CardViewModel]) {
        self.cardViewModels = spadeCardViewModels
    }
}

class DeckViewModelDiamondCards: CardViewModelSection {
    var sectionTitle: String { return Deck.Constants.Diamonds }

    var cardViewModels: [CardViewModel]

    init(diamondCardViewModels: [CardViewModel]) {
        self.cardViewModels = diamondCardViewModels
    }
}
