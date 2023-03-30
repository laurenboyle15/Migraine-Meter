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

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false // changes view in real time
    @Published var locations = [HeadacheLocation]() //array of possible headache locations
    @Published var headacheEntry = [HeadacheEntry]()
        //array to hold all entries from user
    @Published var foodLog = [FoodLog]()
        //array to hold food entry
    @Published var headacheHistory = [HeadacheEntry]()
    
    
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
    
    //adds food to list
    func add (entry: FoodLog) {
        foodLog.append(entry)
    }
    
    //adds headache to users log
    func addHeadacheEntry(hEntry: HeadacheEntry) {
        headacheEntry.append(hEntry)
    }
    
    //saves headache entry to db
    func saveHeadacheEntry(user: String, location: String, intensity: String, duration: String, trigger: String, remedy: String, sleep: String, notes: String, breakfast: String, lunch: String, dinner: String, waterAmount: String, exerciseEntry: String, date: Date) {
        let db = Firestore.firestore()
        db.collection("hEntry").addDocument(data: ["user": user, "location": location, "intensity": intensity, "duration": duration, "trigger": trigger, "remedy": remedy, "sleep": sleep, "notes": notes, "breakfast": breakfast, "lunch": lunch, "dinner": dinner, "waterAmount": waterAmount, "exerciseEntry": exerciseEntry, "date": date]) { error in
            if error == nil {
                //no errors
                print("No errors")
            } else {
                
            }
        }

    }
    
    //get headache entries from db
    func getHeadacheEntry() {
        //ref to db
        let db = Firestore.firestore()
        
        //read docs at specific path
        db.collection("hEntry").getDocuments { snapshot, error in
            //check for errors
            if error == nil {
                //no errors
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        //get all docs and create entry
                        self.headacheHistory = snapshot.documents.map { d in
                            
                            //create an entry item for each doc in db
                            return HeadacheEntry(id: d.documentID,
                                                 user: d["user"] as? String ?? "",
                                                 location: d["location"] as? String ?? "",
                                                 intensity: d["intensity"] as? String ?? "",
                                                 duration: d["duration"] as? String ?? "",
                                                 trigger: d["trigger"] as? String ?? "",
                                                 remedy: d["remedy"] as? String ?? "",
                                                 sleep: d["sleep"] as? String ?? "",
                                                 notes: d["notes"] as? String ?? "",
                                                 breakfast: d["breakfast"] as? String ?? "",
                                                 lunch: d["lunch"] as? String ?? "",
                                                 dinner: d["dinner"] as? String ?? "",
                                                 waterAmount: d["waterAmount"] as? String ?? "",
                                                 exerciseEntry: d["exerciseEntry"] as? String ?? "",
                                                 date: (d["date"] as? Timestamp)?.dateValue() ?? Date() )
                        }
                    }
                }
            } else {
                //handle errors
            }
        }
    }
    
    //get subset of headache entries from db
    func getUserHEntry() {
        //ref to db
        let db = Firestore.firestore()
        
        //read docs for this user
        db.collection("hEntry").whereField("user", isEqualTo: Auth.auth().currentUser?.email ?? "").getDocuments { snapshot, error in
            //check for errors
            if error == nil {
                //no errors
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        //get all docs and create an entry
                        self.headacheHistory = snapshot.documents.map { d in
                            //create entry item for each doc of this user
                            return HeadacheEntry(id: d.documentID,
                                                 user: d["user"] as? String ?? "",
                                                 location: d["location"] as? String ?? "",
                                                 intensity: d["intensity"] as? String ?? "",
                                                 duration: d["duration"] as? String ?? "",
                                                 trigger: d["trigger"] as? String ?? "",
                                                 remedy: d["remedy"] as? String ?? "",
                                                 sleep: d["sleep"] as? String ?? "",
                                                 notes: d["notes"] as? String ?? "",
                                                 breakfast: d["breakfast"] as? String ?? "",
                                                 lunch: d["lunch"] as? String ?? "",
                                                 dinner: d["dinner"] as? String ?? "",
                                                 waterAmount: d["waterAmount"] as? String ?? "",
                                                 exerciseEntry: d["exerciseEntry"] as? String ?? "",
                                                 date: (d["date"] as? Timestamp)?.dateValue() ?? Date() )
                        }
                    }
                }
            } else {
                //handle errors
            }
        }
        
    }
    
    //function to delete user data
    func deleteUserHEntry(entryToDelete: HeadacheEntry) {
        //ref to db
        let db = Firestore.firestore()
        
        //specify doc to delete
        db.collection("hEntry").document(entryToDelete.id).delete { error in
            //check for errors
            if error == nil {
                //no errors
                
                //Update UI for main thread
                DispatchQueue.main.async {
                    //remove entry from history that was deleted from db
                    self.headacheHistory.removeAll { entry in
                        
                        //Check for the entry to remove
                        return entry.id == entryToDelete.id
                    }
                }
            }
        }
    }
    
    //function that gets the possible location options from db
    func getLocations() {
        let db = Firestore.firestore()
        
        //read doc at specific path
        db.collection("headachelocation").getDocuments { snapshot, error in
            //check for errors
            if error == nil {
                //no errors
                print("No errors")
                
                if let snapshot = snapshot {
                    
                    //update in main thread
                    DispatchQueue.main.async {
                        //get all docs and display possible locations
                        self.locations = snapshot.documents.map { d in
                            
                            //create location from each retrieved item
                            return HeadacheLocation(id: d.documentID, name: d["name"] as? String ?? "")
                        }
                    }
                }
            } else {
                //handle the errors
            }
        }
    }
}


struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            // checks if user is signed in and changes view to homescreen at open
            if viewModel.signedIn {
                TabView {
                    HeadacheLogScreen(entryHeadache: HeadacheEntry.examplehEntry)
                        .environmentObject(viewModel)
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
