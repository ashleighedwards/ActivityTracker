//
//  DailyGoalsListView.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 28/10/2023.
//

import SwiftUI
import CoreData

struct DailyGoalsListView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var activity: FetchedResults<Activity>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    @FetchRequest(sortDescriptors: []) var goals: FetchedResults<Goals>
    
    @State private var showingAddGoalView = false
    
    let magenta = Color("Shape color 1")
    let pink = Color("Shape color 2")
    let maroon = Color("Shape color 3")
    let sys = Color("Color")
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                ForEach(goals) { goals in
                    NavigationLink(destination: EditGoalsView(goals: goals)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(magenta)
                                .frame(width: 170, height: 170)
                     
                            Circle()
                            .trim(from: 0, to: progress(percentage: goalsPercentage(goals: goals.caloriesIn, total: totalCaloriesInToday())))
                            .stroke(sys, lineWidth:8)
                            .frame(width:150)
                            .rotationEffect(Angle(degrees:-90))
                            VStack {
                                Text("Calories in").foregroundColor(.white)
                                Text("Goal: \(Int(goals.caloriesIn)) Kcal").bold().foregroundColor(.white)
                                Text("\(totalCaloriesInToday(), specifier: "%.0f") Kcal").foregroundColor(.white)
                                Text("\(goalsPercentage(goals: goals.caloriesIn, total: totalCaloriesInToday()), specifier: "%.1f")%").foregroundColor(.white)
                            }
                            
                        }
                    }
                    NavigationLink(destination: EditGoalsView(goals: goals)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(pink)
                                .frame(width: 170, height: 170)
                            Circle()
                            .trim(from: 0, to: progress(percentage: goalsPercentage(goals: goals.caloriesOut, total: totalCaloriesOutToday())))
                            .stroke(sys, lineWidth:8)
                            .frame(width:150)
                            .rotationEffect(Angle(degrees:-90))
                            VStack {
                                Text("Calories Out").foregroundColor(.white)
                                Text("Goal: \(Int(goals.caloriesOut)) Kcal").bold().foregroundColor(.white)
                                Text("\(totalCaloriesOutToday(), specifier: "%.0f") Kcal").foregroundColor(.white)
                                Text("\(goalsPercentage(goals: goals.caloriesOut, total: totalCaloriesOutToday()), specifier: "%.1f")%").foregroundColor(.white)
                            }
                        }
                    }
                    NavigationLink(destination: EditGoalsView(goals: goals)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(maroon)
                                .frame(width: 170, height: 170)
                            
                            Circle()
                            .trim(from: 0, to: progress(percentage: goalsPercentage(goals: goals.time, total: totalActivityToday())))
                            .stroke(sys, lineWidth:8)
                            .frame(width:150)
                            .rotationEffect(Angle(degrees:-90))
                            VStack {
                                Text("Amount of Activity").foregroundColor(.white)
                                Text("Goal: \(Int(goals.time)) mins").bold().foregroundColor(.white)
                                Text("\(totalActivityToday(), specifier: "%.0f") mins").foregroundColor(.white)
                                Text("\(goalsPercentage(goals: Double(goals.time), total: totalActivityToday()), specifier: "%.1f")%").foregroundColor(.white)
                            }
                        }
                    }
                }
            }.navigationBarTitle("Activity tracker", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddGoalView.toggle()
                    } label: {
                        Label("Add Activity", systemImage: "plus.circle")
                    }.opacity(goalsEntered() ? 0 : 1)
                }
            }
            .sheet(isPresented: $showingAddGoalView) {
                AddGoalView()
            }
        }
        
    }
    
    private func totalCaloriesInToday() -> Double {
        var caloriesIn: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesIn += item.calories
            }
        }
        return caloriesIn
    }
    
    private func totalCaloriesOutToday() -> Double {
        var caloriesOut: Double = 0
        for item in activity {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesOut += item.calories
            }
        }
        return caloriesOut
    }
    
    private func goalsPercentage(goals: Double, total: Double) -> Double {
        let percentage: Double = total/goals * 100
        
        return percentage
    }
    
    private func progress(percentage: Double) -> Double {
        return percentage/100
    }
    
    private func totalActivityToday() -> Double {
        var timeAdded: Double = 0
        for item in activity {
            if Calendar.current.isDateInToday(item.date!) {
                timeAdded += round(item.length/60)
            }
        }

        return timeAdded
    }
    
    private func goalsEntered() -> Bool {
        if goals.isEmpty{
            return false
        }
        else {
            return true
        }
    }
}

