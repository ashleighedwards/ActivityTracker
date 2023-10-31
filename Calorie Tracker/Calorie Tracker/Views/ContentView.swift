//
//  ContentView.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 27/10/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TabView() {
                    FoodListView().tabItem() {
                        Label(
                        title: {Text("Food")},
                        icon: { Image(systemName: "fork.knife.circle.fill")}
                    )}
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
                    ActivityListView().tabItem() {
                        Label(
                        title: {Text("Activity")},
                        icon: { Image(systemName: "figure.walk.circle.fill")}
                    )}
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
                    DailyGoalsListView().tabItem() {
                        Label(
                        title: {Text("Daily Goals")},
                        icon: { Image(systemName: "target")}
                    )}
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
                    SettingsListView().tabItem() {
                        Label(
                        title: {Text("Settings")},
                        icon: { Image(systemName: "gearshape.fill")}
                    )}
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                }
                .listStyle(.plain)
            }
            .navigationBarTitle("Tracker", displayMode: .inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
