//
//  ListModel.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation

struct ListQuotes: Codable {
    let success: Bool
    let currencies: [String: String]
}

struct ListQuotesCache {
    static let key = "listQuotesCache"
    static func save(_ value: ListQuotes!) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> ListQuotes! {
        var userData: ListQuotes!
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(ListQuotes.self, from: data)
            return userData!
        } else {
            return userData
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
