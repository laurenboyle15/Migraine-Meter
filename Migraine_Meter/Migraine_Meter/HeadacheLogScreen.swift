//
//  HeadacheLogScreen.swift
//  Migraine_Meter
//
//  Created by lauren boyle on 2/20/23.
//

import SwiftUI

struct HeadacheLogScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Text("Enter Headache")
                .foregroundColor(Color.red)
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

struct HeadacheLogScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadacheLogScreen()
    }
}
