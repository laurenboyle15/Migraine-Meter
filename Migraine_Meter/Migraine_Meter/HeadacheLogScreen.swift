//
//  HeadacheLogScreen.swift
//  Migraine_Meter
//  Screen where users can input data for migraine entry. Saves to db
//  Created by lauren boyle on 2/20/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct HeadacheLogScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    //@ObservedObject var model = AppViewModel()
   
    @State private var location = "Back"
    let locations = ["Back", "Eyes", "Forehead", "Side", "Top"]
    @State private var pickedIntensity = "3"
    let intensity = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    @State private var pickedDuration = "1 hour"
    let duration = ["Less than 1 hour", "1 hour", "2 hours", "3 hours", "4 hours", "5 hours", "6 hours", "7 hours", "8 hours", "1 day", "More than a day"]
    @State private var pickedTrigger = "Stress"
    let trigger = ["Stress", "Exercise", "Bright Lights", "Loud Noise", "Caffeine", "Menstration", "Weather"]
    @State private var pickedRemedy = "Medication"
    let remedy = ["Medication", "Sleep", "Meditation", "Food", "Caffeine", "Hydration", "Cold/Warm Compress"]
    @State private var pickedSleepLength = "8 hours"
    let sleepLength = ["Less than 4 hours", "4 hours", "5 hours", "6 hours", "7 hours", "8 hours", "9 hours", "10 hours", "Over 10 hours"]
    @State private var notes = ""
    
    //toggles whether food entry or not
    @State private var food = false
    @State private var breakfast = ""
    @State private var lunch = ""
    @State private var dinner = ""
    
    //toggles whether water entry or not
    @State private var water = false
    @State private var waterAmount = ""
    
    //toggles whether water entry or not
    @State private var exercise = false
    @State private var exerciseEntry = ""
    
    let entryHeadache: HeadacheEntry
    //let food: FoodLog
    
    //to get current user
    let db = Firestore.firestore()
    var userEmail = Auth.auth().currentUser?.email
    var userName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Migraine Entry")
                        .font(.largeTitle)
                        .fontWeight(.black)) {
                Picker("Where is your pain located?", selection: $location) {
                    ForEach(locations, id: \.self) {
                            Text($0)
                    }
                }
                    if (location == "Back") {
                        Image("Back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipped()
                    } else if (location == "Eyes") {
                        Image("Eyes")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipped()
                    } else if (location == "Forehead") {
                        Image("Forehead")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipped()
                    } else if (location == "Side") {
                        Image("Side")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipped()
                    } else {
                        Image("Top")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipped()
                    }

                Picker("Intensity", selection: $pickedIntensity) {
                    ForEach(intensity, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                Picker("Duration", selection: $pickedDuration) {
                    ForEach(duration, id: \.self) {
                        Text($0)
                    }
                }.padding()
                    .border(.black, width:4)

                Picker("Trigger", selection: $pickedTrigger) {
                    ForEach(trigger, id: \.self) {
                        Text($0)
                    }
                }.padding()
                    .border(.black, width:4)

                Picker("Remedy", selection: $pickedRemedy) {
                    ForEach(remedy, id: \.self) {
                        Text($0)
                    }
                }.padding()
                    .border(.black, width:4)
                            
                Picker("Sleep", selection: $pickedSleepLength) {
                    ForEach(sleepLength, id: \.self) {
                        Text($0)
                    }
                }.padding()
                    .border(.black, width:4)
                
                HStack {
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(.blue)
                    Button("Food") {
                        food.toggle()
                    }
                    
                    //whether these fields should appear or not
                    if food {
                        VStack {
                            TextField("Breakfast", text: $breakfast)
                            TextField("Lunch", text: $lunch)
                            TextField("Dinner", text: $dinner)
                        }
                    }
                    
                }
                HStack {
                    Image(systemName: "plus.app.fill")
                    .foregroundColor(.blue)
                    Button("Water") {
                        water.toggle()
                    }
                    
                    //whether fields should appear or not
                    if water {
                        VStack {
                            TextField("Fluid Ounces", text: $waterAmount)
                        }
                    }
                }
                HStack {
                    Image(systemName: "plus.app.fill")
                    .foregroundColor(.blue)
                    Button("Exercise") {
                        exercise.toggle()
                    }
                    
                    //whether fields should appear
                    if exercise {
                        VStack {
                            TextField("Exercise", text: $exerciseEntry)
                        }
                    }
                }
            }
            Section {
                TextField("Other Notes...", text: $notes)
                    .frame(height: 80)
            }
            Button("Add Entry") {
                viewModel.saveHeadacheEntry(user: userEmail ?? userName, location: location, intensity: pickedIntensity, duration: pickedDuration, trigger: pickedTrigger, remedy: pickedRemedy, sleep: pickedSleepLength, notes: notes, breakfast: breakfast, lunch: lunch, dinner: dinner, waterAmount: waterAmount, exerciseEntry: exerciseEntry, date: Date.now)
            }
            //}
            
        }
        
            //Button {
            //   viewModel.signOut()
            //} label: {
            //    Text("Sign Out")
            //        .foregroundColor(Color.red)
            // }
       // }
    }
}

struct HeadacheLogScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadacheLogScreen(entryHeadache: HeadacheEntry.examplehEntry)
            .environmentObject(AppViewModel())
    }
}
