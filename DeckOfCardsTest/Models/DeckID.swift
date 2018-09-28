//
//  DeckID.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import Foundation

struct DeckId: Decodable {

    let deckId: String

    private enum CodingKeys: String, CodingKey {
        case deckId = "deck_id"
    }
}
