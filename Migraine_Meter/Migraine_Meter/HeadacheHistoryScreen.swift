//
//  HeadacheHistoryScreen.swift
//  Migraine_Meter
//  Displays all user migraine entries read in from DB
//  Created by lauren boyle on 2/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct HeadacheHistoryScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    //for the date picker
    @State private var date = Date()
    //for navigation
    @State private var navigation = false
    //for the entry
    //let entry: HeadacheEntry
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("History", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                ForEach(model.headacheHistory) { item in
                    if (Calendar.current.isDate(date, equalTo: item.date, toGranularity: .day)) {
                        NavigationLink(destination: EntryDetail(entryDetail: item)) {
                            Text(item.date.formatted(date: .long, time: .omitted))
                        }
                    }
                }
            
            }
           /*List {
               ForEach(model.headacheHistory) { item in
                    NavigationLink(destination: EntryDetail(entryDetail: item)) {
                        Text(item.date.formatted(date: .long, time: .omitted))
                    }
                }
           } */
           .navigationTitle("Migraine History")
        }
                       /*
                        if (item.location == "Back") {
                            Image("Back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipped()
                        } else if (item.location == "Eyes") {
                            Image("Eyes")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipped()
                        } else if (item.location == "Forehead") {
                            Image("Forehead")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipped()
                        } else if (item.location == "Side") {
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
                        } */
                            //Text(item.date.formatted(date: .long, time: .omitted))
                        
                    
                
            //}
        
        /*VStack {
            Text("Your Migraine History")
                .foregroundColor(Color.blue)
                .font(.largeTitle)
                .fontWeight(.bold)
            Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
                    .foregroundColor(Color.red)
            }
        }
        List (model.headacheHistory) { item in
            Text(item.user)
        }
        NavigationView {
            VStack {
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .onChange(of: date) { newValue in
                    navigate = true
                }
            }
            List (model.headacheHistory) { item in
                Text(item.user)
            }
        }
        List (model.headacheHistory) { item in
            Text(item.user)
        } */
    }
    
    init() {
        model.getUserHEntry()
    }
}

struct HeadacheHistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadacheHistoryScreen()
    }
}
