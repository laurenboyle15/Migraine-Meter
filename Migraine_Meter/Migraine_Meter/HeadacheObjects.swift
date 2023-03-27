//
//  HeadacheObjects.swift
//  Migraine_Meter
//  Holds all structs related to headaches
//  Created by lauren boyle on 2/27/23.
//

import SwiftUI

struct HeadacheLocation: Identifiable {
    var id: String
    var name: String
}

struct FoodLog: Identifiable, Codable, Equatable {
    let id = UUID()
    var entry: String
    
    #if DEBUG
    static let exampleFood = FoodLog(entry: "Eggs, Bagel, Cheese")
    #endif
}

struct HeadacheEntry: Identifiable, Codable, Equatable {
    var id: String
    var user: String
    var location: String
    var intensity: String
    var duration: String
    var trigger: String
    var remedy: String
    var sleep: String
    var notes: String
    var breakfast: String
    var lunch: String
    var dinner: String
    var waterAmount: String
    var exerciseEntry: String
    var date: Date
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: date)
    }
    
    
    #if DEBUG
    static let examplehEntry = HeadacheEntry(id: "10", user: "lb123@gmail.com", location: "Eyes", intensity: "8", duration: "4 hours", trigger: "weather", remedy: "medication", sleep: "8 hours", notes: "slept it off", breakfast: "Eggs, Bagel, Cheese", lunch: "salad", dinner: "spaghetti and meatballs", waterAmount: "40 fl oz", exerciseEntry: "1 mile run", date: Date.now)
    #endif
}


