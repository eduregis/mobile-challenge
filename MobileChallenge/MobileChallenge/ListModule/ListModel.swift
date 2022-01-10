//
//  ListModel.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation

struct ListQuotes: Decodable {
    let success: Bool
    let currencies: [String: String]
}
