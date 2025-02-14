//
//  CoreDataManager.swift
//  MatchMate
//
//  Created by Mansi Laad on 13/02/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MatchMateModel")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchUserProfiles() -> [UserProfile] {
        let request: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching user profiles: \(error)")
            return []
        }
    }
    
    func saveUserProfile(from result: Result, status: String?) {
        let context = persistentContainer.viewContext
        let userProfile = UserProfile(context: context)
        userProfile.id = result.id
        userProfile.firstName = String(result.name.first)
        userProfile.lastName = String(result.name.last)
        userProfile.age = Int16(result.dob.age)
        userProfile.city = String(result.location.city)
        userProfile.state = result.location.state
        userProfile.status = status
        saveContext()
    }

    func updateUserProfileStatus(id: String, status: String) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            if let userProfile = try context.fetch(request).first {
                userProfile.status = status
                saveContext()            }
        } catch {
            print("Error updating user profile status: \(error)")
        }
    }
    
}
