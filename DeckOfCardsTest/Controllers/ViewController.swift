//
//  ViewController.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DataService.shared.fetchFullDeck { (deck, error) in
            if let deck = deck {
                for card in deck.cards {
                    print("\(card.value) of \(card.suit)")
                }
            }
        }
    }


}



