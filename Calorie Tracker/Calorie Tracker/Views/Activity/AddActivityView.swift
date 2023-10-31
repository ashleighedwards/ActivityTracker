//
//  AddActivityView.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 27/10/2023.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss

    @State private var activityName = ""
    @State private var calories: Double = 0
    @State private var startDate = Date.now
    @State private var endDate = Date.now

    var body: some View {
        Form {
            Section {
                TextField("Activity", text: $activityName)

                VStack {
                    Text("Calories burnt: \(Int(calories))")
                    Slider(value: $calories, in: 0...5000, step: 1)
                    Text("Length of Activity: \(calcActivityString(startDate: startDate, endDate: endDate))")
                    DatePicker("Start Time", selection: $startDate, displayedComponents: .hourAndMinute)
                    DatePicker("End Time", selection: $endDate, displayedComponents: .hourAndMinute)
                }
                .padding()

                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addActivity(activityName: activityName, startDate: startDate, endDate: endDate, calories: calories, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
    }
}
