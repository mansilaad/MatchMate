//
//  MatchViewModel.swift
//  MatchMate
//
//  Created by Mansi Laad on 13/02/25.
//

import Foundation
import Combine
import CoreData

class MatchViewModel: ObservableObject {
    @Published var users: [Result] = []
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiURL = "https://randomuser.me/api/?results=10"
    //private let coreDataManager = CoreDataManager.shared
    
    init() {
        fetchUsers()
    }
    
    /// Fetch users from API or Core Data if offline
    func fetchUsers() {
        if NetworkMonitor.shared.isConnected {
            fetchFromAPI()
        } else {
            //fetchFromCoreData()
        }
    }
    
    func fetchFromAPI() {
        guard let url = URL(string: apiURL) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\ .data)
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to load users: \(error.localizedDescription)"
                }
            }, receiveValue: { response in
                //DispatchQueue.main.async {
                    self.users = response
                    print("Fetched Users: \(response)")
                //}
            })
            .store(in: &cancellables)
    }
    
    /// Fetch users from Core Data
//    private func fetchFromCoreData() {
//        users = coreDataManager.loadUsers()
//    }
    
    
    
    /// Accept/Decline match
//    func updateMatchStatus(user: Result, status: Result.MatchStatus) {
//        if let index = users.firstIndex(where: { $0.id == user.id }) {
//            users[index].status = status
//            coreDataManager.updateUserStatus(id: user.id, status: status)
//        }
//    }
    
}

