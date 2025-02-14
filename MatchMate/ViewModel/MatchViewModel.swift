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
    @Published var statusDict: [String: String] = [:] // Stores status per user ID
    
    private var cancellables = Set<AnyCancellable>()
    private let apiURL = "https://randomuser.me/api/?results=10"
    private let coreDataManager = CoreDataManager.shared

    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        if NetworkMonitor.shared.isConnected {
            fetchFromAPI()
        } else {
            fetchFromCoreData()
        }
    }
    
    func fetchFromAPI() {
        guard let url = URL(string: apiURL) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to load users: \(error.localizedDescription)"
                }
            }, receiveValue: { response in
                self.users = response
                self.saveUsersToCoreData(response) // Save users to Core Data
                self.loadStatusFromCoreData() // Load status from Core Data

            })
            .store(in: &cancellables)
    }
    
    func fetchFromCoreData() {
        let userProfiles = coreDataManager.fetchUserProfiles()
        self.users = userProfiles.map { result in
            Result(
                gender: .male, // Default value, adjust as needed
                name: Name(title: "", first: result.firstName ?? "", last: result.lastName ?? ""),
                location: Location(
                    street: Street(number: 0, name: ""),
                    city: result.city ?? "",
                    state: result.state ?? "",
                    country: "",
                    postcode: .string(""),
                    coordinates: Coordinates(latitude: "", longitude: ""),
                    timezone: Timezone(offset: "", description: "")
                ),
                email: "",
                login: Login(uuid: result.id ?? "", username: "", password: "", salt: "", md5: "", sha1: "", sha256: ""),
                dob: Dob(date: "", age: Int(result.age)),
                registered: Dob(date: "", age: 0),
                phone: "",
                cell: "",
                idInfo: ID(name: "", value: nil),
                picture: Picture(large: "", medium: "", thumbnail: ""),
                nat: "",
                status: result.status
            )
        }
    }
    
    func saveUsersToCoreData(_ users: [Result]) {
        for user in users {
            coreDataManager.saveUserProfile(from: user, status: statusDict[user.id])
        }
    }
            
    func loadStatusFromCoreData() {
            let userProfiles = coreDataManager.fetchUserProfiles()
            for profile in userProfiles {
                if let id = profile.id, let status = profile.status {
                    statusDict[id] = status
                }
            }
        }

    
    func updateUserStatus(id: String, status: String) {
        print("calling update user \(status)")
        statusDict[id] = status // Update status in the dictionary
        
        print("dict \(statusDict)")
        coreDataManager.updateUserProfileStatus(id: id, status: status) // Save to Core Data
        objectWillChange.send() // Manually trigger a UI update

    }

}
