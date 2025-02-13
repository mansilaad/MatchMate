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
    @Published var users: [UserProfile] = []
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiURL = "https://randomuser.me/api/?results=10"
    private let coreDataManager = CoreDataManager.shared
    
    init() {
        fetchUsers()
    }
    
    /// Fetch users from API or Core Data if offline
    func fetchUsers() {
        if NetworkMonitor.shared.isConnected {
            fetchFromAPI()
        } else {
            fetchFromCoreData()
        }
    }
    
    /// Fetch users from API
    private func fetchFromAPI() {
        guard let url = URL(string: apiURL) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map { response in
                response.results.map { user in
                    UserProfile(
                        id: user.login.uuid,
                        name: "\(user.name.first) \(user.name.last)",
                        age: user.dob.age,
                        location: "\(user.location.city), \(user.location.country)",
                        imageUrl: user.picture.large,
                        status: nil
                    )
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to load users: \(error.localizedDescription)"
                }
            }, receiveValue: { users in
                self.users = users
                self.coreDataManager.saveUsers(users)
            })
            .store(in: &cancellables)
    }
    
    /// Fetch users from Core Data
    private func fetchFromCoreData() {
        users = coreDataManager.loadUsers()
    }
    
    /// Accept/Decline match
    func updateMatchStatus(user: UserProfile, status: UserProfile.MatchStatus) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index].status = status
            coreDataManager.updateUserStatus(id: user.id, status: status)
        }
    }
}

