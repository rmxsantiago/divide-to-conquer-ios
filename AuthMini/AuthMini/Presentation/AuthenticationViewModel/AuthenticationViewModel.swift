//
//  FaceIDViewModel.swift
//  AuthMini
//
//  Created by Rafael Santiago on 01/04/2020.
//  Copyright © 2020 Rafael Santiago. All rights reserved.
//

import Foundation
import LocalAuthentication
import SwiftUI

class AuthenticatorViewModel : ObservableObject {
    private var context : LAContext?
    @Published var state = AuthenticationState.logged_out
    
    init() {
        context = LAContext()
        if let safeContext = self.context {
            safeContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        }
        
        state = AuthenticationState.logged_out
    }
    
    func authBtnPressed() {
        if state == .logged_in {
            state = .logged_out
        } else {
            SecurityRespository.getAuthorization { success, error in
                if success {
                    DispatchQueue.main.async { [unowned self] in
                        self.state = .logged_in
                    }
                } else {
                    print(error?.localizedDescription ?? "Failed to authenticate")
                }
            }
        }
    }
    
    func getAuthButtonLabel() -> String {
        return self.getAuthButtonLabel(state: self.state, biometryType: self.context!.biometryType)
    }
    
    func getStateLabel(_ state: AuthenticationState) -> String {
        return checkLoggedInState(state) ? "Log In" : "Log Out"
    }
    
    private func getAuthButtonLabel(state: AuthenticationState, biometryType: LABiometryType) -> String {
        return self.getBiometryLabel(biometryType)
    }   
    
    private func getBiometryLabel(_ biometryType: LABiometryType) -> String {
        return checkIsFaceIDBiometryType(biometryType) ? "Face ID" : "Touch ID"
    }
    
    private func checkIsFaceIDBiometryType(_ biometryType: LABiometryType) -> Bool {
        return biometryType == .faceID
    }
    
    private func checkLoggedInState(_ state: AuthenticationState) -> Bool {
        return state == .logged_in
    }
}
