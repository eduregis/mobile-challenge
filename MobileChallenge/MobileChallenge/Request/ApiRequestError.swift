//
//  FetchError.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation

enum ApiRequestError: Error {
    case invalidUrl
    case noInternetConnection
    case decodingError
    case responseError
    case quoteNotFound
}
