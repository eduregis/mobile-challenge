//
//  ConverterModel.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation
import UIKit

class LiveQuotes: Decodable {
    let success: Bool
    let source: String
    let quotes: [String: CGFloat]
}
