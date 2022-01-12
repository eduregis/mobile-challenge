//
//  ConverterModel.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation
import UIKit

struct LiveQuotes: Codable {
    let success: Bool
    let source: String
    let quotes: [String: CGFloat]
}

struct LiveQuotesCache {
    static let key = "liveQuotesCache"
    static func save(_ value: LiveQuotes!) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> LiveQuotes! {
        var userData: LiveQuotes!
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(LiveQuotes.self, from: data)
            return userData!
        } else {
            return userData
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
