//
//  SettingsListView.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 30/10/2023.
//

import SwiftUI

struct SettingsListView: View {
    @State private var lightMode = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    HStack {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                    }
                }
            }.navigationBarTitle("Activity tracker", displayMode: .inline)
        }
    }
}
