//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Bryan Gomez on 8/3/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardController {
    //https://deckofcardsapi.com/api/deck/new/draw/?count=1
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        // URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        print(baseURL)
            // Contact Server
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                if let card = topLevelObject.cards.first {
                    return completion(.success(card))
                } else {
                    completion(.failure(.noData))
                }
                
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {
        guard let imageURL = card.image else { return completion(.failure(.invalidURL))}
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            return completion(.success(image))
        }.resume()
    }
}
