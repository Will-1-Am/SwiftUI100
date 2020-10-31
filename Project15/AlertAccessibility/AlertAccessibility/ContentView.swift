//
//  ContentView.swift
//  AlertAccessibility
//
//  Created by William Spanfelner on 13/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var displayAlert = false
    
    var body: some View {
        Toggle(isOn: $displayAlert) {
            Text("Show alert")
        }
        .alert(isPresented: $displayAlert) {
            Alert(title: Text("This is a Test. \nThis is a test of the emergency broadcast system. \nTap OK to dismiss."), message: nil, dismissButton: .default(Text("OK")))
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
