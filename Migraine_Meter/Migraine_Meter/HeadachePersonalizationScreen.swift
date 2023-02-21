//
//  HeadachePersonalizationScreen.swift
//  Migraine_Meter
//
//  Created by lauren boyle on 2/21/23.
//

import SwiftUI

struct HeadachePersonalizationScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Text("Personalize Your Migraine Experience")
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

struct HeadachePersonalizationScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeadachePersonalizationScreen()
    }
}
