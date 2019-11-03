//
//  SteppingUp.swift
//  iExpense
//
//  Created by William Spanfelner on 29/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct SteppingUp: View {
    @State private var sleepAmount = 8.0
    
    @State private var xTable = 1
    
    @State private var age = 18
    
//    @State private var stepperChanged = false
    
    var body: some View {
        
        VStack {
            Stepper(value: $sleepAmount) {
                Text("\(sleepAmount) hours")
            }
            
            // Limit the stepper range like this
            Stepper(value: $sleepAmount, in: 4 ... 12) {
                Text("\(sleepAmount) hours")
            }
            
            // Increment in prescribed steps like this:
            Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%.2f") hours")
            // “%g” specifier removes insignificant zeros
            }
            
            Stepper(value: $xTable, in: 1 ... 12) {
                Text("Practice the \(xTable) times table")
            }
            
//            Stepper("Enter your age", onIncrement: {
////                self.age += 1
////                self.celebrate()
//            }, onDecrement: {
//                self.age -= 1
//            })
//            Text("Your age is: \(age)")
            
            
            Stepper(value: $age, onEditingChanged: { _ in 
                self.celebrate()
            }) {
                Text("Age stepper value: \(self.age)")
            }
        }
    }
    
    func celebrate() {
        print("Happy Birthday")
        self.age += 10
    }
}

struct SteppingUp_Previews: PreviewProvider {
    static var previews: some View {
        SteppingUp()
    }
}
