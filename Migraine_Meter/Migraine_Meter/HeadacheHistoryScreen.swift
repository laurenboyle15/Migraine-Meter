//
//  HeadacheHistoryScreen.swift
//  Migraine_Meter
//
//  Created by lauren boyle on 2/21/23.
//

import SwiftUI

struct HeadacheHistoryScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
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
    }
}

struct HeadacheHistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadacheHistoryScreen()
    }
}
