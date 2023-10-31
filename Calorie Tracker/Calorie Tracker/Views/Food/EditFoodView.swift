//
//  EditFoodView.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 27/10/2023.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("\(food.name!)", text: $name)
                        .onAppear {
                            name = food.name!
                            calories = food.calories
                        }
                    VStack {
                        Text("Calories \(Int(calories))")
                        Slider(value: $calories, in: 0...3000, step: 10)
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        Button("Submit") {
                            DataController().editFood(food: food, name: name, calories: calories, context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }.navigationBarHidden(true)
        }.navigationBarTitle("Edit food", displayMode: .inline)
    }
}

