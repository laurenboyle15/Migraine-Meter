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
    
    //toggles whether alert should appear or not
    @State private var showingAlert = false
    
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
    
    //to find common triggers
    var commonTriggers: [String] {
        //array to hold all trigger entries
        var ctArray = [String]()
        
        //array to hold possible food triggers
        var commonTriggersArray = [String]()
        
        //now have array of triggers when migraine this month
        for item in model.headacheHistory {
            //check if the user entries occured in current month
            if (Calendar.current.isDate(item.date, equalTo: currentDate, toGranularity: .month)) {
                ctArray.append(item.trigger)
            }
        }
        
        //make array count duplicate keys
        var counts: [String: Int] = [:]
        
        //loop through array and increment value of key if occurs again
        for item in ctArray {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        //checking the key value counts and adding to returned array
        for(key, value) in counts {
            if (value > 2) {
                commonTriggersArray.append(key)
            }
        }
        
        return commonTriggersArray
    }
    
    //to find when migraine occurs from dehydration
    var hydrationTrigger: Int {
        var count = 0
        
        for item in model.headacheHistory {
            //check if the user entries occured in current month
            if (Calendar.current.isDate(item.date, equalTo: currentDate, toGranularity: .month)) {
                //check if migraine entry had enough water
                //using mayo clinic
                //3.7 liter men = about 120 fl oz
                //2.7 liter women = about 91 fl oz
                //right now using 8 cups = 65 fl oz
                //convert amount to double
                let waterAmountDouble = Double(item.waterAmount) ?? 0
                //still need to check if female
                if (waterAmountDouble < 65) {
                    count = count + 1
                }
                //still need to check if male
               // if (currentUserSex == "Male" && waterAmountDouble < 100) {
               //     count = count + 1
               // }
        
            }
        }
        
        return count
    }
    
    //to find when migraine occurs from lack of sleep
    var sleepTrigger: Int {
        var count = 0
        
        for item in model.headacheHistory {
            //check if the user entries occured in current month
            if (Calendar.current.isDate(item.date, equalTo: currentDate, toGranularity: .month)) {
                //check if migraine entry had enough sleep
                //using 8 hours as baseline
                //convert amount to double
                let sleepAmountDouble = Double(item.sleep) ?? 0
                //still need to check if female
                if (sleepAmountDouble < 8) {
                    count = count + 1
                }
                //still need to check if male
               // if (currentUserSex == "Male" && waterAmountDouble < 100) {
               //     count = count + 1
               // }
        
            }
        }
        
        return count
    }
    
    var textView: some View {
        VStack(spacing: 20){
            Text("Migraine Meter")
                .foregroundColor(Color.red)
                .font(.largeTitle)
                .fontWeight(.bold)
            
           // Form {
           //     Section(header: Text("Report for this month")
           //                 .font(.largeTitle)
           //                 .fontWeight(.black)) {
                    HStack {
                        Text("Total migraines: ")
                        Spacer()
                        Text("\(countNum)")
                    }
          
                    HStack {
                        Text("Average Intensity: ")
                        Spacer()
                        Text("\(avgIntensity)")
                    }
           
                    HStack {
                        Text("Average Duration:  ")
                        Spacer()
                        Text("\(avgDuration) hours")
                    }
            
                    HStack {
                        Text("Possible triggers: ")
                        Spacer()
                        VStack {
                            ForEach(commonTriggers, id: \.self) { trigger in
                                Text(trigger)
                            }
                            if (hydrationTrigger > 2) {
                                Text("Dehydration")
                            }
                            if (sleepTrigger > 2) {
                                Text("Lack of Sleep")
                            }
                        }
                    }
                    HStack {
                        Image(systemName: "fork.knife.circle.fill")
                        Text("Foods to keep an eye on: ")
                        Spacer()
                        VStack {
                            ForEach(foodTriggers, id: \.self) { food in
                                Text(food)
                            }
                        }
                    }
                   /* if (hydrationTrigger > 2) {
                        HStack {
                            Image(systemName: "drop.fill")
                            Text("Possible triggered from dehydration: ")
                            Spacer()
                            Text("\(hydrationTrigger)")
                        }
                    } */
             //   }
                
                
            //    Button {
            //         viewModel.signOut()
            //     } label: {
            //         Text("Sign Out")
            //             .foregroundColor(Color.red)
            //     }
           // }
        } 
    }
    
    var body: some View {
        VStack {
            /*Text("Migraine Meter")
                .foregroundColor(Color.red)
                .font(.largeTitle)
                .fontWeight(.bold) */
           /* Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
                    .foregroundColor(Color.red)
            } */
            
          /*  Form {
                Section(header: Text("Report for this month")
                            .font(.largeTitle)
                            .fontWeight(.black)) {
                    HStack {
                        Text("Total migraines: ")
                        Spacer()
                        Text("\(countNum)")
                    }
                    HStack {
                        Text("Average Intensity: ")
                        Spacer()
                        Text("\(avgIntensity)")
                    }
                    HStack {
                        Text("Average Duration:  ")
                        Spacer()
                        Text("\(avgDuration) hours")
                    }
                    HStack {
                        Text("Possible triggers: ")
                        Spacer()
                        VStack {
                            ForEach(commonTriggers, id: \.self) { trigger in
                                Text(trigger)
                            }
                            if (hydrationTrigger > 2) {
                                Text("Dehydration")
                            }
                            if (sleepTrigger > 2) {
                                Text("Lack of Sleep")
                            }
                        }
                    }
                    HStack {
                        Image(systemName: "fork.knife.circle.fill")
                        Text("Foods to keep an eye on: ")
                        Spacer()
                        VStack {
                            ForEach(foodTriggers, id: \.self) { food in
                                Text(food)
                            }
                        }
                    }
                   /* if (hydrationTrigger > 2) {
                        HStack {
                            Image(systemName: "drop.fill")
                            Text("Possible triggered from dehydration: ")
                            Spacer()
                            Text("\(hydrationTrigger)")
                        }
                    } */
                }
                
                
                Button {
                     viewModel.signOut()
                 } label: {
                     Text("Sign Out")
                         .foregroundColor(Color.red)
                 }
                
                
                
            } */
            Divider()
            
            textView
            
            Divider()
            
            HStack {
                Button("Save Report") {
                    let image = textView.snapshot()
                    
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    
                    //let user know added
                    showingAlert = true
                } .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Saved to camera roll"),
                          dismissButton: .destructive(Text("Dismiss")))
                }
                Spacer()
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

//for screenshot
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self.edgesIgnoringSafeArea(.all))
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

struct HeadacheAnalyticsScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadacheAnalyticsScreen()
    }
}
