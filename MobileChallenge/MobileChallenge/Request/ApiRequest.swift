//
//  ApiRequest.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation

class ApiRequest {
    private enum Endpoint: String {
        case list = "/list"
        case live = "/live"
    }
    
    private let networkMonitor = NetworkMonitor.shared
    private let url = "https://btg-mobile-challenge.herokuapp.com"
        
    private func getUrl(_ endpoint: Endpoint) -> String {
        return url + endpoint.rawValue
    }
    
    func getListQuotes(completionHandler: @escaping (Result<ListQuotes, ApiRequestError>) -> Void) {
        guard networkMonitor.isReachable else {
            if let response = ListQuotesCache.get() {
                return completionHandler(.success(response))
            } else {
                return completionHandler(.failure(.noInternetConnection))
            }
        }
        let urlString = getUrl(.list)
        guard let url = URL(string: urlString) else { return completionHandler(.failure(ApiRequestError.invalidUrl)) }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return completionHandler(.failure(ApiRequestError.responseError)) }
            do {
                let response = try JSONDecoder().decode(ListQuotes.self, from: data)
                ListQuotesCache.save(response)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(ApiRequestError.decodingError))
            }
        }
        task.resume()
    }
    
    func getLiveQuotes(completionHandler: @escaping (Result<LiveQuotes, ApiRequestError>) -> Void) {
        guard networkMonitor.isReachable else {
            if let response = LiveQuotesCache.get() {
                return completionHandler(.success(response))
            } else {
                return completionHandler(.failure(.noInternetConnection))
            }
        }
        let urlString = getUrl(.live)
        guard let url = URL(string: urlString) else { return completionHandler(.failure(ApiRequestError.invalidUrl)) }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return completionHandler(.failure(ApiRequestError.responseError)) }
            do {
                let response = try JSONDecoder().decode(LiveQuotes.self, from: data)
                LiveQuotesCache.save(response)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(ApiRequestError.decodingError))
            }
        }
        
        task.resume()
    }
}
