//
//  MigrainePainScaleInfo.swift
//  Migraine_Meter
//  Display the info for pain scale
//  Created by lauren boyle on 4/25/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct MigrainePainScaleInfo: View {
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var model = AppViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("MigrainePainScale")
                    //.interpolation(.none)
                    .resizable()
                    .scaledToFit()
            } .navigationBarHidden(true)
        } //.navigationBarTitle("Scale Information")
    }
}

struct MigrainePainScaleInfo_Previews: PreviewProvider {
    static var previews: some View {
        MigrainePainScaleInfo()
    }
}
