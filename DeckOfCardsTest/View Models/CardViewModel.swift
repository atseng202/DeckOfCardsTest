//
//  CardViewModel.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import Foundation
import UIKit

class CardViewModel: Comparable {
    static func < (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return lhs.intValue < rhs.intValue
    }

    static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return lhs.intValue == rhs.intValue
    }

    let suit: String
    let value: String
    let imageUrl: String
    private let intValue: Int

    init(card: Card) {
        self.suit = card.suit
        self.value = card.value
        self.imageUrl = card.image

        // Now get Int value to make it easier to sort later
        self.intValue = valueToIntDict[self.value] ?? 0 
    }

    private var valueToIntDict: [String: Int] = [
        Deck.Constants.Ace: 1,
        Deck.Constants.Two: 2,
        Deck.Constants.Three: 3,
        Deck.Constants.Four: 4,
        Deck.Constants.Five: 5,
        Deck.Constants.Six: 6,
        Deck.Constants.Seven: 7,
        Deck.Constants.Eight: 8,
        Deck.Constants.Nine: 9,
        Deck.Constants.Ten: 10,
        Deck.Constants.Jack: 11,
        Deck.Constants.Queen: 12,
        Deck.Constants.King: 13,
    ]
}
