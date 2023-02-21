//
//  ContentView.swift
//  Migraine_Meter
//  Creates neccessary methods for authentication and creating a user
//  Created by lauren boyle on 2/14/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false // changes view in real time
    
    // changes variable in real time
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    // function called to check if user is in database
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            //Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    // the function that is called to create a user in the database
    func signUp(email: String, password: String, name: String, dob: String, sex: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            let db = Firestore.firestore()
            
            db.collection("users").addDocument(data: ["firstName": name, "email": email, "dob": dob, "sex": sex, "uid": result!.user.uid]) { error in
                if error == nil {
                    //No errors
                    print("No errors")
                } else {
                    
                }
            }
            guard result != nil, error == nil else {
                
                return
            }
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
        }
    }
    
    // function that signs out user once button is clicked
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}


struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            // checks if user is signed in and changes view to homescreen at open
            if viewModel.signedIn {
                TabView {
                    HeadacheLogScreen()
                        .tabItem{
                            Label("Home", systemImage: "square.and.pencil")
                        }
                    HeadacheHistoryScreen()
                        .tabItem {
                            Label("History", systemImage: "calendar")
                        }
                    HeadachePersonalizationScreen()
                        .tabItem {
                            Label("Personalize", systemImage: "brain.head.profile")
                        }
                    HeadacheAnalyticsScreen()
                        .tabItem {
                            Label("Analytics", systemImage: "ruler")
                        }
                }
            }
            else {
                SignInView()
            }
        }.navigationBarHidden(true).onAppear() {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
