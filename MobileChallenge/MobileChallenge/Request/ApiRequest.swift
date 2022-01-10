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
    
    private let url = "https://btg-mobile-challenge.herokuapp.com"
        
    private func getUrl(_ endpoint: Endpoint) -> String {
        return url + endpoint.rawValue
    }
    
    func getListOfQuotes(completionHandler: @escaping (Result<ListQuotes, ApiRequestError>) -> Void) {
        let urlString = getUrl(.list)
        guard let url = URL(string: urlString) else { return completionHandler(.failure(ApiRequestError.invalidUrl)) }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return completionHandler(.failure(ApiRequestError.responseError)) }
            do {
                let response = try JSONDecoder().decode(ListQuotes.self, from: data)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(ApiRequestError.decodingError))
            }
        }
        task.resume()
    }
    
    func getCurrentQuotes(completionHandler: @escaping (Result<CurrentQuotes, ApiRequestError>) -> Void) {
        let urlString = getUrl(.live)
        guard let url = URL(string: urlString) else { return completionHandler(.failure(ApiRequestError.invalidUrl)) }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return completionHandler(.failure(ApiRequestError.responseError)) }
            do {
                let response = try JSONDecoder().decode(CurrentQuotes.self, from: data)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(ApiRequestError.decodingError))
            }
        }
        
        task.resume()
    }
}
