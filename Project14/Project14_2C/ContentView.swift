//
//  ContentView.swift
//  BucketList - Project 14 - Challenge 2 - Having a complex if condition in the middle of ContentView isn’t easy to read – can you rewrite it so that the MapView, Circle, and Button are part of their own view? This might take more work than you think!
//
//  Created by William Spanfelner on 30/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
//import MapKit
import LocalAuthentication

struct ContentView: View {
    //MARK: Is the device unlocked?
    @State private var isUnlocked = true
    
    var body: some View {
        ZStack{
            if isUnlocked {
                
                ConsolidatedMapViewCircleButton()
                
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
            .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
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
