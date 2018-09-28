//
//  Deck.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import Foundation

struct Deck: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let value: String
    let image: String
    let suit: String 
}
