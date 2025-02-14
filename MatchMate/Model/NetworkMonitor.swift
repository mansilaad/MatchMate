//
//  NetworkMonitor.swift
//  MatchMate
//
//  Created by Mansi Laad on 13/02/25.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                print("Network Status Updated: \(self?.isConnected == true ? "Connected" : "Disconnected")")
            }
        }
        monitor.start(queue: queue)
    }
}



