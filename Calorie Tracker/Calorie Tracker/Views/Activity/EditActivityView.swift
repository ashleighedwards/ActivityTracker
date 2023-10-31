//
//  EditActivityView.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 27/10/2023.
//

import SwiftUI

struct EditActivityView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var activity: FetchedResults<Activity>.Element
    
    @State private var activityName = ""
    @State private var calories: Double = 0
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("\(activity.activityName!)", text: $activityName)
                        .onAppear {
                            activityName = activity.activityName!
                            calories = activity.calories
                            startDate = activity.startDate!
                            endDate = activity.endDate!
                        } .padding()
                    VStack {
                        Text("Calories burnt \(Int(calories))")
                        Slider(value: $calories, in: 0...2000, step: 10)
                        Text("Length of Activity: \(calcActivityString(startDate: startDate, endDate: endDate))")
                        DatePicker("Start Time", selection: $startDate, displayedComponents: .hourAndMinute)
                        DatePicker("End Time", selection: $endDate, displayedComponents: .hourAndMinute)
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        Button("Submit") {
                            DataController().editActivity(activity: activity, activityName: activityName, startDate: startDate, endDate: endDate, calories: calories, context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }.navigationBarHidden(true)
        }.navigationBarTitle("Edit activity", displayMode: .inline)
    }
}
