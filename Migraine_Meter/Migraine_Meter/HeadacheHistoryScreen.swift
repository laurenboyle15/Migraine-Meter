//
//  HeadacheHistoryScreen.swift
//  Migraine_Meter
//  Displays all user migraine entries read in from DB
//  Created by lauren boyle on 2/21/23.
//

import SwiftUI

struct HeadacheHistoryScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    
    var body: some View {
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
        } */
        List (model.headacheHistory) { item in
            Text(item.user)
        }
    }
    
    init() {
        model.getHeadacheEntry()
    }
}

struct HeadacheHistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadacheHistoryScreen()
    }
}
