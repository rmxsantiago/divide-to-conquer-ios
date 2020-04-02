//
//  SecurityRepository.swift
//  AuthMini
//
//  Created by Rafael Santiago on 02/04/2020.
//  Copyright © 2020 Rafael Santiago. All rights reserved.
//

import Foundation
import LocalAuthentication

struct SecurityRespository {
    static func getAuthorization(completion: @escaping (Bool, Error?) -> Void ) {
        let context = LAContext()
        
        context.localizedCancelTitle = "Enter Username/Password"
        
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                completion(success, error)
            }
        } else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            completion(false, error)
        }
    }
}
