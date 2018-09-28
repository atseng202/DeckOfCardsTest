//
//  DataService.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case error(String)
    case invalidStatusCode(String)
    case noDataReturned(String)
    case failedToParseJSON(String)
}

class DataService {
    static let shared = DataService()

    private let session = URLSession.shared

    func fetchFullDeck(completion: @escaping (Deck?, NetworkError?) -> Void) {
        fetchDeckId { (deckId, networkError) in
            guard let deckId = deckId else {
                completion(nil, networkError)
                return
            }
            self.fetchFullDeckOfCards(withDeckId: deckId, completion: { (deck, error) in
                guard let deck = deck else {
                    completion(nil, error)
                    return
                }

                completion(deck, nil)
            })

        }
    }

    private func fetchFullDeckOfCards(withDeckId deckId: DeckId, completion: @escaping (Deck?, NetworkError?) -> Void) {

        var params: [String: Any] = [:]
        params[Constants.ParameterKeys.Count] = "\(52)"
        var mutableMethod = Constants.Methods.DrawCards
        mutableMethod = substituteKeyInMethod(mutableMethod, key: Constants.URLKeys.DeckID, value: deckId.deckId)

        let deckURL = getURLFromParameters(params, withPathExtension: mutableMethod)
        let request = URLRequest(url: deckURL)

        let task = session.dataTask(with: request) { (data, response, err) in
            guard err == nil else {
                completion(nil, NetworkError.error("There was an error with the request: \(err!.localizedDescription)"))
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(nil, NetworkError.invalidStatusCode("Request returned a status code other than 2xx"))
                return
            }

            guard let data = data else {
                completion(nil, NetworkError.noDataReturned("No data returned by request!"))
                return
            }

            var deck: Deck!
            do {
                deck = try JSONDecoder().decode(Deck.self, from: data)
            } catch let error {
                completion(nil, NetworkError.failedToParseJSON("Could not parse the data into JSON: \(data)"))
            }

            completion(deck, nil)

        }
        task.resume()
    }

    private func fetchDeckId(completion: @escaping (DeckId?, NetworkError?) -> Void) {
        var params: [String: Any] = [:]
        params[Constants.ParameterKeys.DeckCount] = "\(1)"

        let deckIdUrl = getURLFromParameters(params, withPathExtension: Constants.Methods.GetDeckID)
        let request = URLRequest(url: deckIdUrl)

        let task = session.dataTask(with: request) { (data, response, err) in
            guard err == nil else {
                completion(nil, NetworkError.error("There was an error with the request: \(err!.localizedDescription)"))
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completion(nil, NetworkError.invalidStatusCode("Request returned a status code other than 2xx"))
                return
            }

            guard let data = data else {
                completion(nil, NetworkError.noDataReturned("No data returned by request!"))
                return
            }

            var deckId: DeckId!
            do {
                deckId = try JSONDecoder().decode(DeckId.self, from: data)
            } catch let error {
                completion(nil, NetworkError.failedToParseJSON("Could not parse the data into JSON: \(data)"))
            }

            completion(deckId, nil)

        }
        task.resume()

    }

    private func getURLFromParameters(_ parameters: [String: Any], withPathExtension pathExtension: String? = nil) -> URL {

        var components = URLComponents()
        var queryItems = [URLQueryItem]()

        components.scheme = Constants.ApiScheme
        components.host = Constants.ApiHost
        components.path = Constants.ApiPath + (pathExtension ?? "")

        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItems.append(queryItem)
        }

        components.queryItems = queryItems

        return components.url!
    }

    private func substituteKeyInMethod(_ method: String, key: String, value: String) -> String {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return method
        }
    }
}
