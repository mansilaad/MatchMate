//
//  CoreDataManager.swift
//  MatchMate
//
//  Created by Mansi Laad on 13/02/25.
//
//
//import CoreData
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//    private let container: NSPersistentContainer
//
//    init() {
//        container = NSPersistentContainer(name: "MatchMateDB")
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                print("Core Data load error: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    var context: NSManagedObjectContext {
//        return container.viewContext
//    }
//
//    /// Save users to Core Data
//    func saveUsers(_ users: [Result]) {
//        users.forEach { user in
//            let entity = UserEntity(context: context)
//            entity.id = user.id
//            entity.name = user.name
//            entity.age = Int16(user.age)
//            entity.location = user.location
//            entity.imageUrl = user.imageUrl
//            entity.status = user.status?.rawValue
//        }
//        saveContext()
//    }
//
//    /// Load users from Core Data
//    func loadUsers() -> [Result] {
//        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
//        do {
//            let entities = try context.fetch(request)
//            return entities.map {
//                UserProfile(
//                    id: $0.id ?? "",
//                    name: $0.name ?? "",
//                    age: Int($0.age),
//                    location: $0.location ?? "",
//                    imageUrl: $0.imageUrl ?? "",
//                    status: UserProfile.MatchStatus(rawValue: $0.status ?? "")
//                )
//            }
//        } catch {
//            print("Failed to fetch users: \(error.localizedDescription)")
//            return []
//        }
//    }
//
//    /// Update user match status
//    func updateUserStatus(id: String, status: UserProfile.MatchStatus) {
//        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "id == %@", id)
//
//        do {
//            if let entity = try context.fetch(request).first {
//                entity.status = status.rawValue
//                saveContext()
//            }
//        } catch {
//            print("Failed to update status: \(error.localizedDescription)")
//        }
//    }
//
//    /// Save Core Data context
//    private func saveContext() {
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save Core Data: \(error.localizedDescription)")
//        }
//    }
//}
