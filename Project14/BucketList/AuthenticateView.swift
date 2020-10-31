//
//  AuthenticateView.swift
//  BucketList
//
//  Created by William Spanfelner on 02/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct AuthenticateView: View {
        @State private var isUnlocked = false
        
    var body: some View {
        ZStack{
            
            VStack {
                if self.isUnlocked {
                    Text("Unlocked")
                } else {
                    Text("Locked")
                }
            }
            .onAppear(perform: authenticate)
            MapView()
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        //check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            //its possible so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                //authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        //authenticated successfully
                        self.isUnlocked = true
                    } else {
                        //there was a problem
                    }
                }
            }
        } else {
            //no biometrics
        }
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView()
    }
}
