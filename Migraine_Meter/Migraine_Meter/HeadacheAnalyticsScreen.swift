//
//  HeadacheAnalyticsScreen.swift
//  Migraine_Meter
//
//  Created by lauren boyle on 2/21/23.
//

import SwiftUI

struct HeadacheAnalyticsScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Text("Migraine Meter")
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

struct HeadacheAnalyticsScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadacheAnalyticsScreen()
    }
}
