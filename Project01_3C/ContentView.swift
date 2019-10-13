//
//  ContentView.swift
//  WeSplit - Challenge 3 - Change the “Number of people” picker to be a text field, making sure to use the correct keyboard type.
//
//  Created by William Spanfelner on 09/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
/*
 ContentView.swift contains the initial user interface (UI) for your program, and is where we’ll be doing all the work in this project.
 
 Tip: Very often you’ll find that an error in your code stops Xcode’s canvas from updating – you’ll see something like “Automatic preview updating paused”, and can press Resume to fix it. As you’ll be doing this a lot, let me recommend an important shortcut: Option+Cmd+P does the same as clicking Resume.
 */

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    //Challenge 3 - Change the numberOfPeople type to String
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //calculate the total per person here
        //Challenge 3 - Downcast numberOfPeople as Double and use nil-coalescing to account for nil case.  Also, ensure peopleCount is assigned sensible value with ternary check.
        let people = Double(numberOfPeople) ?? 2
        let peopleCount = people > 0 ? people : 2
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        //print(peopleCount, tipSelection, orderAmount, tipValue, grandTotal, amountPerPerson)
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter bill amount", text: $checkAmount)
                        //MARK: keyboardType displays the appropriate keyboard for the type of UI
                        .keyboardType(.decimalPad)
                }
                //Challenge 3 - Change the Picker to a TextField and specify numberpad as we are interested in whole persons only...
                Section(header: Text(verbatim: "Enter number of people sharing bill:")) {
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)

                }
                
//                Section(header: Text("Select number of people")){
////                    TextField("Test", text: $numberOfPeople ?? 0)
//                    //                    TextField("Number of people", text: $numberOfPeople)
//                    //                        .keyboardType(.decimalPad)
//
//                    Picker("Number of people:", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
//                }

                Section(header: Text("How much tip do you want to leave?")) {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Sum payable per person:")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
