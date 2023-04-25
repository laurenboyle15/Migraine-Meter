//
//  UpdateTrigger.swift
//  Migraine_Meter
//  Allows user to update their trigger
//  Created by lauren boyle on 4/24/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct UpdateTrigger: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    
    let updateTrigger: PersonalizationEntry
    @State private var editedTrigger = ""
    
    //to get current user
    let db = Firestore.firestore()
    var userEmail = Auth.auth().currentUser?.email
    
    var body: some View {
        NavigationView {
            HStack {
                Text(updateTrigger.trigger)
                TextField("Update", text: $editedTrigger)
                Button("Save") {
                    model.updateUserHPersonalizationTrigger(personalizationFieldToUpdate: updateTrigger, update: editedTrigger)
                    editedTrigger = ""
                }
            }
        }
    }
}

struct UpdateTrigger_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTrigger(updateTrigger: PersonalizationEntry.examplepEntry)
            .environmentObject(AppViewModel())
    }
}
