//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Bryan Gomez on 8/3/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    let cards: [Card]
}
struct Card: Decodable {
    let image: URL?
    let value: String
    let suit: String
}
