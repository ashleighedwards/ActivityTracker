//
//  EditGoalsView.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 28/10/2023.
//

import SwiftUI

struct EditGoalsView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var goals: FetchedResults<Goals>.Element
    
    @State private var caloriesIn: Double = 0
    @State private var caloriesOut: Double = 0
    @State private var time: Double = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        Text("Calories in goal: \(Int(caloriesIn)) kcal")
                        Slider(value: $caloriesIn, in: 0...5000, step: 100)
                        Text("Calories out goal: \(Int(caloriesOut)) kcal")
                        Slider(value: $caloriesOut, in: 0...5000, step: 100)
                        Text("Time goal: \(Int(time)) minutes")
                        Slider(value: $time, in: 0...500, step: 10)
                    }.onAppear {
                        caloriesIn = goals.caloriesIn
                        caloriesOut = goals.caloriesOut
                        time = goals.time
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        Button("Submit") {
                            DataController().editGoals(goals: goals, caloriesIn: caloriesIn, caloriesOut: caloriesOut, time: time, context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }.navigationBarHidden(true)
        }.navigationBarTitle("Edit goals", displayMode: .inline)
    }
}
