//
//  UpdateMedication.swift
//  Migraine_Meter
//  Allows user to update their medication
//  Created by lauren boyle on 5/1/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct UpdateMedication: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    
    let updateMedication: PersonalizationEntry
    @State private var editedMedication = ""
    
    //to get current user
    let db = Firestore.firestore()
    var userEmail = Auth.auth().currentUser?.email
    
    var body: some View {
        NavigationView {
            HStack {
                Text(updateMedication.medication)
                Spacer()
                TextField("Update", text: $editedMedication)
                Button("Save") {
                    model.updateUserHPersonalizationMedication(personalizationFieldToUpdate: updateMedication, update: editedMedication)
                    editedMedication = ""
                }
            } .navigationBarHidden(true)
        }
    }
}

struct UpdateMedication_Previews: PreviewProvider {
    static var previews: some View {
        UpdateMedication(updateMedication: PersonalizationEntry.examplepEntry)
            .environmentObject(AppViewModel())
    }
}
