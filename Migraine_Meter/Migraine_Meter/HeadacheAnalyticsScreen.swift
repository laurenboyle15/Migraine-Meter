//
//  HeadacheAnalyticsScreen.swift
//  Migraine_Meter
//  Displays user analytics for current month
//  Created by lauren boyle on 2/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct HeadacheAnalyticsScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    
    //to get current user
    let db = Firestore.firestore()
    var userEmail = Auth.auth().currentUser?.email
    var userName = ""
    
    //to get current date
    @State private var currentDate = Date.now
    
    //to count the migraines
    var countNum: Int {
        var count = 0
        
        for item in model.headacheHistory {
            //check if the user entries occured in current month
            if (Calendar.current.isDate(item.date, equalTo: currentDate, toGranularity: .month)) {
                count = count + 1
            }
        }
        
        return count
    }
    
    //to avg the intensity
    var avgIntensity: String {
        //array to hold intensitys
        var intensityArray = [Double]()
        
        for item in model.headacheHistory {
            //check if the user entries occured in current month
            if (Calendar.current.isDate(item.date, equalTo: currentDate, toGranularity: .month)) {
                let intensityDouble = Double(item.intensity) ?? 0
                intensityArray.append(intensityDouble)
            }
        }
        
        //to find sum
        let sum = intensityArray.reduce(0, +)
        //find length of array
        let length = intensityArray.count
        //find avg
        let avgIntensity = Double(sum)/Double(length)
        
        //to format the number
        let formattedAvgIntenstity = String(format: "%.2f", avgIntensity)
        
        //make sure not returning invalid result
        if (avgIntensity.isNaN) {
            return "0"
        } else {
            return formattedAvgIntenstity
        }
    }
    
    //to avg the duration
    var avgDuration: String {
        //array to hold intensitys
        var durationArray = [Double]()
        
        for item in model.headacheHistory {
            //check if the user entries occured in current month
            if (Calendar.current.isDate(item.date, equalTo: currentDate, toGranularity: .month)) {
                let durationNumber = item.duration.first!
                let durationDouble = Double(String(durationNumber)) ?? 0
                durationArray.append(durationDouble)
            }
        }
        
        //to find sum
        let sum = durationArray.reduce(0, +)
        //find length of array
        let length = durationArray.count
        //find avg
        let avgDuration = Double(sum)/Double(length)
        
        //to format the number
        let formattedAvgDuration = String(format: "%.2f", avgDuration)
        
        if (avgDuration.isNaN) {
            return "0"
        } else {
            return formattedAvgDuration
        }
    }
    
    //to find common food triggers
    var foodTriggers: [String] {
        //array to hold all food entries
        var foodArray = [String]()
        
        //array to hold possible food triggers
        var foodTriggersArray = [String]()
        
        //now have array of food eaten when migraine this month
        for item in model.headacheHistory {
            //check if the user entries occured in current month
            if (Calendar.current.isDate(item.date, equalTo: currentDate, toGranularity: .month)) {
                foodArray.append(item.breakfast)
                foodArray.append(item.lunch)
                foodArray.append(item.dinner)
            }
        }
        
        //make array count duplicate keys
        var counts: [String: Int] = [:]
        
        //loop through array and increment value of key if occurs again
        for item in foodArray {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        //checking the key value counts and adding to returned array
        for(key, value) in counts {
            if (value > 2) {
                foodTriggersArray.append(key)
            }
        }
        
        return foodTriggersArray
    }
    
    var body: some View {
        
        VStack {
            Text("Migraine Meter")
                .foregroundColor(Color.red)
                .font(.largeTitle)
                .fontWeight(.bold)
           /* Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
                    .foregroundColor(Color.red)
            } */
            
            Form {
                Section(header: Text("Report for this month")
                            .font(.largeTitle)
                            .fontWeight(.black)) {
                    Text("Total migraines: \(countNum)")
                    Text("Average Intensity: \(avgIntensity)")
                    Text("Average Duration: \(avgDuration) hours")
                    HStack {
                        Text("Possible food triggers: ")
                        VStack {
                            ForEach(foodTriggers, id: \.self) { food in
                                Text(food)
                            }
                        }
                    }
                }
                
                Button {
                     viewModel.signOut()
                 } label: {
                     Text("Sign Out")
                         .foregroundColor(Color.red)
                 }
                
            }
        }
    }
    
    init() {
        model.getUserHEntry()
    }
}

struct HeadacheAnalyticsScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadacheAnalyticsScreen()
    }
}
