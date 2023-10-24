//
//  todo_applicationApp.swift
//  todo-application
//
//  Created by shreenidhi vm on 24/10/23.
//

import SwiftUI

@main
struct todo_applicationApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkMode") private var isDarkMode:Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
