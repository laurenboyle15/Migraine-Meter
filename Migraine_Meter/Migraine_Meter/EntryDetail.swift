//
//  EntryDetail.swift
//  Migraine_Meter
//  Holds details on the selected migraine entry
//  Created by lauren boyle on 3/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct EntryDetail: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    
    let entryDetail: HeadacheEntry
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Headache")
                    .font(.largeTitle)
                    .fontWeight(.black)) {

                    if (entryDetail.location == "Back") {
                        Image("Back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipped()
                    } else if (entryDetail.location == "Eyes") {
                        Image("Eyes")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipped()
                    } else if (entryDetail.location == "Forehead") {
                        Image("Forehead")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipped()
                    } else if (entryDetail.location == "Side") {
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
                    Text("Intensity: " + entryDetail.intensity)
                    Text("Duration: " + entryDetail.duration)
                    Text("Trigger: " + entryDetail.trigger)
                    Text("Remedy: " + entryDetail.remedy)
                    Text("Hours of sleep: " + entryDetail.sleep)
                    Text("Additional notes : " + entryDetail.notes)
                
                }
                Section (header: Text("Meals")
                    .font(.largeTitle)
                    .fontWeight(.black)) {
                    Text("Breakfast: " + entryDetail.breakfast)
                    Text("Lunch: " + entryDetail.lunch)
                    Text("Dinner: " + entryDetail.dinner)
                }
                Section (header: Text("Water Intake")
                    .font(.largeTitle)
                    .fontWeight(.black)) {
                    Text("Amount of water: " + entryDetail.waterAmount)
                }
                Section (header: Text("Exercise Entry")
                    .font(.largeTitle)
                    .fontWeight(.black)) {
                    Text("Exercise: " + entryDetail.exerciseEntry)
                    Text("Date is: \(entryDetail.date.formatted(date: .long, time: .omitted))")
                }
            }
            
        }.navigationBarTitle("Migraine Details")
    }
}

struct EntryDetail_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetail(entryDetail: HeadacheEntry.examplehEntry)
            .environmentObject(AppViewModel())
    }
}
