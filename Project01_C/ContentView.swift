//
//  ContentView.swift
//  Conversions - build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.
//
//  Created by William Spanfelner on 12/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

//enum lengthUnits {
//    case meters, kilometers, feet, yards, miles
//}

struct ContentView: View {
    //Give the user input TextField a default of 1, & set the segmentedPickers to the middle selection
    @State private var inputVar = "1"
    @State private var inputUnit = 3
    @State private var outputUnit = 3
    
    //An array defines the choices for the segmentedPicker
    var lengthUnits = ["mm", "cm", "m", "km", "inch", "feet", "yard", "mile"]
    
    //The calculated property below converts the input quantity & unit to mm and then to the desired conversion unit
    var conversion: Double {
        let startUnit = lengthUnits[inputUnit]
        var startFactor: Double = 1
        
        let endUnit = lengthUnits[outputUnit]
        var endFactor: Double = 1
        
        switch startUnit {
        case "cm":
            startFactor = 10
        case "m":
            startFactor = 1000
        case "km":
            startFactor = 1000000
        case "inch":
            startFactor = 25.4
        case "feet":
            startFactor = 25.4 * 12
        case "yard":
            startFactor = 25.4 * 12 * 3
        case "mile":
            startFactor = 25.4 * 12 * 5280
        default:
            startFactor = 1
        }

        let mmConversion = startFactor * Double(Double(inputVar) ?? 0)
        
        switch endUnit {
        case "cm":
            endFactor = 1 / 10
        case "m":
            endFactor = 1 / 1000
        case "km":
            endFactor = 1 / 1000000
        case "inch":
            endFactor = 1 / 25.4
        case "feet":
            endFactor = 1 / (25.4 * 12)
        case "yard":
            endFactor = 1 / (25.4 * 12 * 3)
        case "mile":
            endFactor = 1 / (25.4 * 12 * 5280)
        default:
            endFactor = 1
        }
        
        let desiredConversion = mmConversion * endFactor
//        print(inputVar," \(startUnit) is \(desiredConversion) \(endUnit)")
        return desiredConversion
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Units to convert from")) {
                    Picker("Length units", selection: $inputUnit) {
                        ForEach(0 ..< lengthUnits.count) {
                            Text("\(self.lengthUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                
                Section(header: Text("Number of units to convert?")) {
                    TextField("Number to convert?", text: $inputVar)
                        .keyboardType(.decimalPad)
                    
                }
                
                
                Section(header: Text("Units to convert to")) {
                    Picker("Length units", selection: $outputUnit) {
                        ForEach(0 ..< lengthUnits.count) {
                            Text("\(self.lengthUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                //The format specifier allows the converion of small units to very large  unit (eg mm to miles)
                Section(header: Text("The result is:")) {
                    Text("\(self.conversion, specifier: "%.9f")")
                }
            }.navigationBarTitle("Conversions")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
