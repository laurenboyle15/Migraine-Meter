//
//  UpdateRemedy.swift
//  Migraine_Meter
//  Allows user to update a remedy
//  Created by lauren boyle on 5/1/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct UpdateRemedy: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    
    let updateRemedy: PersonalizationEntry
    @State private var editedRemedy = ""
    
    //to get current user
    let db = Firestore.firestore()
    var userEmail = Auth.auth().currentUser?.email
    
    var body: some View {
        NavigationView {
            HStack {
                Text(updateRemedy.remedy)
                Spacer()
                TextField("Update", text: $editedRemedy)
                Button("Save") {
                    model.updateUserHPersonalizationRemedy(personalizationFieldToUpdate: updateRemedy, update: editedRemedy)
                    editedRemedy = ""
                }
            } .navigationBarHidden(true)
        }
    }
}

struct UpdateRemedy_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRemedy(updateRemedy: PersonalizationEntry.examplepEntry)
            .environmentObject(AppViewModel())
    }
}
