//
//  ActivityLength.swift
//  Calorie Tracker
//
//  Created by Ashleigh Edwards on 27/10/2023.
//

import Foundation
import CoreData

func calcActivityInSeconds(startDate: Date, endDate: Date) -> Double {
    let timeLength: Double = (startDate.distance(to: endDate))
    
    return timeLength
}

func calcSecondsToTotal(seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = seconds % 3600 / 60
    let seconds = seconds % 3600 % 60
    
    return "\(Int(hours))h \(Int(minutes))m \(Int(seconds))s"
}

func calcActivityString(startDate: Date, endDate: Date) -> String {
    let timeLength: Int = Int(startDate.distance(to: endDate))
    let hours = timeLength / 3600
    let minutes = timeLength % 3600 / 60
    let seconds = timeLength % 3600 % 60
    
    return "\(Int(hours))h \(Int(minutes))m \(Int(seconds))s"
}
