//
//  ContentView.swift
//  BucketList - Project 14 - Challenge 3 - Our app silently fails when errors occur during biometric authentication. Add code to show those errors in an alert, but be careful: you can only add one alert() modifier to each view.
//
//  Created by William Spanfelner on 30/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    //MARK: Is the device unlocked?
    @State private var isUnlocked = false
    
    //MARK: Challenge 3 - State properties for the Alert switch and the error message to display
    @State private var unlockError = false
    @State private var unlockErrorMessage = ""
    
    var body: some View {
        ZStack{
            if isUnlocked {
                
                ConsolidatedMapViewCircleButton()
                
            } else {
                // add button here
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $unlockError) {
            Alert(title: Text("Authentication Error"), message: Text(unlockErrorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    /*
     MARK: authenticate will handle all of the biometrics and will:
     1. create an LAContext for performing authentication;
     2. determine whether the device is capable of biometrics;
     3. start the request, if possible, and run a closure on completion;
     4. push work back to the main thread, when everything finishes;
     5. if all successful, set isUnlocked to true

     */
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            //MARK: The following reason is for TouchID as it must be provided in code.
            let reason = "Please authenticate yourself to unlock your places"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                        
                    } else {
                        // error
                        /* */
                        //Challenge 3 - get a reference to the error and flip the unlockError bool to display alert
                        self.unlockErrorMessage = authenticationError?.localizedDescription ?? "Unknown error"
                        self.unlockError = true
                    }
                }
            }
        } else {
            //no biometrics
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
