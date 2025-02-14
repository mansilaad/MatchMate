//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Mansi Laad on 13/02/25.
//

import SwiftUI
import CoreData

@main
struct MatchMateApp: App {
    let persistentContainer = CoreDataManager.shared.persistentContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
