//
//  DataService+Constants.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import Foundation

extension DataService {
    struct Constants {
        static let ApiScheme = "https"
        static let ApiHost = "deckofcardsapi.com"
        static let ApiPath = "/api"

        struct Methods {
            // Deck
            static let GetDeckID = "/deck/new/shuffle"
            static let DrawCards = "/deck/{deckId}/draw"
        }

        struct URLKeys {
            static let DeckID = "deckId"
        }

        struct ParameterKeys {
            static let DeckCount = "deck_count"
            static let Count = "count"
        }
    }
}
