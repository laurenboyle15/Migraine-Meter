//
//  HeadacheObjects.swift
//  Migraine_Meter
//
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
    let id = UUID()
    var location: String
    var intensity: String
    var duration: String
    var trigger: String
    var remedy: String
    var sleep: String
    var notes: String
    
    #if DEBUG
    static let examplehEntry = HeadacheEntry(location: "Eyes", intensity: "8", duration: "4 hours", trigger: "weather", remedy: "medication", sleep: "8 hours", notes: "slept it off")
    #endif
}
