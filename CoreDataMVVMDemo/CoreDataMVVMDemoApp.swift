//
//  CoreDataMVVMDemoApp.swift
//  CoreDataMVVMDemo
//
//  Created by Paulo Orquillo on 13/08/21.
//

import SwiftUI

@main
struct CoreDataMVVMDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
