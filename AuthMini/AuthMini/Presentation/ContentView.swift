//
//  ContentView.swift
//  AuthMini
//
//  Created by Rafael Santiago on 01/04/2020.
//  Copyright © 2020 Rafael Santiago. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @ObservedObject var viewModel = AuthenticatorViewModel()
    
    var body: some View {
        VStack(spacing: 50) {
            
            Text(self.viewModel.getStateLabel(self.viewModel.state))
                .bold()
            
            VStack(alignment: .center) {
                Button(action: self.viewModel.authBtnPressed) {
                    Text(self.viewModel.getAuthButtonLabel())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
