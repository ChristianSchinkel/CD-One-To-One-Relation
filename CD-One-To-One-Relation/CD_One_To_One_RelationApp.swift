//
//  CD_One_To_One_RelationApp.swift
//  CD-One-To-One-Relation
//
//  Created by Christian Schinkel on 2022-12-22.
//

import SwiftUI

@main
struct CD_One_To_One_RelationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
