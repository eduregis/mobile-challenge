//
//  FetchError.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import Foundation

import Network

enum ApiRequestError: Error {
    case invalidUrl
    case noInternetConnection
    case decodingError
    case responseError
    case quoteNotFound
}

class NetworkMonitor {
  static let shared = NetworkMonitor()
  var isReachable: Bool { status == .satisfied }

  private let monitor = NWPathMonitor()
  private var status = NWPath.Status.requiresConnection

  private init() {
    startMonitoring()
  }

  func startMonitoring() {
    monitor.pathUpdateHandler = { [weak self] path in
      self?.status = path.status
    }
    let queue = DispatchQueue(label: "NetworkMonitor")
    monitor.start(queue: queue)
  }

  func stopMonitoring() {
    monitor.cancel()
  }
}
