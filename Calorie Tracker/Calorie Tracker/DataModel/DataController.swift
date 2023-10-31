//
//  DataController.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 27/10/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let activitycontainer = NSPersistentContainer(name: "ActivityModel")
    
    init() {
        activitycontainer.loadPersistentStores {desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!")
        } catch {
            print("We could not save the data")
        }
    }
    
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext) {
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
    func addActivity(activityName: String, startDate: Date, endDate: Date, calories: Double, context: NSManagedObjectContext){
        let activity = Activity(context: context)
        activity.id = UUID()
        activity.date = Date()
        activity.activityName = activityName
        activity.calories = calories
        activity.startDate = startDate
        activity.endDate = endDate
        activity.length = calcActivityInSeconds(startDate: startDate, endDate: endDate)
        
        save(context: context)
    }
    
    func editActivity(activity: Activity, activityName: String, startDate: Date, endDate: Date, calories: Double, context: NSManagedObjectContext) {
        activity.activityName = activityName
        activity.calories = calories
        activity.startDate = startDate
        activity.endDate = endDate
        activity.length = calcActivityInSeconds(startDate: startDate, endDate: endDate)
        
        save(context: context)
    }
    
    func addGoals(caloriesIn: Double, caloriesOut: Double, time: Double, context: NSManagedObjectContext) {
        let goals = Goals(context: context)
        goals.caloriesIn = caloriesIn
        goals.caloriesOut = caloriesOut
        goals.time = time
        
        save(context: context)
    }
    
    func editGoals(goals: Goals, caloriesIn: Double, caloriesOut: Double, time: Double, context: NSManagedObjectContext) {
        goals.caloriesIn = caloriesIn
        goals.caloriesOut = caloriesOut
        goals.time = time
        
        save(context: context)
    }
}
