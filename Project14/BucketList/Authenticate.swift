//
//  Authenticate.swift
//  BucketList
//
//  Created by William Spanfelner on 01/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import LocalAuthentication

//func authenticate() {
//    let context = LAContext()
//    var error: NSError?
////    @Binding var isUnlocked: Bool
//    
//    //check whether biometric authentication is possible
//    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//        //its possible so go ahead and use it
//        let reason = "We need to unlock your data."
//        
//        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
//            //authentication has now completed
//            DispatchQueue.main.async {
//                if success {
//                    //authenticated successfully
//                    self.isUnlocked = true
////                    self.isUnlocked = true
//                } else {
//                    //there was a problem
//                }
//            }
//        }
//    } else {
//        //no biometrics
//    }
//}
