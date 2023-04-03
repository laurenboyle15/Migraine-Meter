//
//  HeadachePersonalizationScreen.swift
//  Migraine_Meter
//  Allows users to enter details of their personal experience
//  Created by lauren boyle on 2/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct HeadachePersonalizationScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    
    @State var medication = ""
    @State var remedy = ""
    @State var trigger = ""
   
    //to get current user
    let db = Firestore.firestore()
    var userEmail = Auth.auth().currentUser?.email
    var userName = ""
    
    var body: some View {
        VStack {
            Text("Personalize Your Migraine Experience")
                .foregroundColor(Color.blue)
                .font(.largeTitle)
                .fontWeight(.bold)
            Form {
                Section(header: Text("Medication")
                            .font(.largeTitle)
                            .fontWeight(.black)) {
                    ForEach(model.headachePersonalization) { item in
                        if(item.medication != "") {
                            Text(item.medication)
                        }
                    }
                }
                Section(header: Text("Remedies")
                            .font(.largeTitle)
                            .fontWeight(.black)) {
                    ForEach(model.headachePersonalization) { item in
                        if (item.remedy != "") {
                            Text(item.remedy)
                        }
                    }
                }
                Section(header: Text("Triggers")
                            .font(.largeTitle)
                            .fontWeight(.black)) {
                    ForEach(model.headachePersonalization) { item in
                        if (item.trigger != "") {
                            Text(item.trigger)
                        }
                    }
                }
            }
            
            Divider()
            
            VStack(spacing: 5) {
                TextField("Medication", text: $medication)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Remedy", text: $remedy)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Trigger", text: $trigger)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    //call save h personal
                    viewModel.saveHPersonalization(medication: medication, remedy: remedy, trigger: trigger, user: userEmail ?? userName)
                    //clear fields
                    medication = ""
                    remedy = ""
                    trigger = ""
                    
                }, label: {
                    Text("Add personalizations")
                })
            }
            .padding()
            /*Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
                    .foregroundColor(Color.red)
            }
        } */
        }
    }
    
    init() {
        model.getUserHPersonalization()
    }
}

struct HeadachePersonalizationScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadachePersonalizationScreen()
    }
}
