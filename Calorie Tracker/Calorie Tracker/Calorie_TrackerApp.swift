//
//  Calorie_TrackerApp.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 27/10/2023.
//

import SwiftUI

@main
struct Calorie_TrackerApp: App {
    @StateObject private var dataController = DataController()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.activitycontainer.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
