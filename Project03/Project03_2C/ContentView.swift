//
//  ContentView.swift
//  WeSplit Project 3 Challenge 2 - Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.
//
//  Created by William Spanfelner on 09/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.


import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
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
                    
                    Picker("Number of people:", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much do you want to tip?")) {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                //MARK: Challenge 2 - Add conditional modifier to change background color of the "Total amount" field to red when the tip = 0% ☑️
                Section(header: Text("Total amount with gratuity:")) {
                    Text("$\(totalPerPerson * Double(numberOfPeople + 2), specifier: "%.2f")")
                        //MARK: Applying the frame modifier here results in the desired effect in that the tip selected is 0% with a background expanded to fill the extents of the view but also has the undesired effect of centering the text in the overall view. - solution: add the alignment parameter to the frame modifier.
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(tipPercentages[tipPercentage] == 0 ? Color.red : Color.white)
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
