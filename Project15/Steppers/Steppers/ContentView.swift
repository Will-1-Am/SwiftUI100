//
//  ContentView.swift
//  Steppers - Just a little practice project to get my head round accessibility with Steppers
//
//  Created by William Spanfelner on 09/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var rating = 3
    
    @State private var speed = 50.0
    
    var body: some View {
//        VStack {
            
            Stepper(value: $rating, in: 1 ... 5) {
                Text("Rate our service: \n") +
                    Text("\(rating) out of 5 stars")
            }
            .frame(height: 50.0)
            .accessibility(label: Text("Rate us"))
            .accessibility(hint: Text("5 being the best, rate us from 1 to 5."))
            .accessibility(value: Text("Current rating is \(rating) out of 5 stars"))

//            Section(header: Text("Set your speed: \n") + Text("\(speed, specifier: "%.1f") kph")) {
//                Slider(value: $speed, in: 0.0 ... 100.0)
//            }
//            .frame(height: 50.0)
//
//        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





//struct ContentView: View {
//    var user = User()
//    @State private var score = 0
//
//
//
//    var body: some View {
//        VStack {
//            Stepper(value: $rating, in: 1 ... 5) {
//                Text("Rate our service \(rating)/5")
//                    + Text(rating == 1 ? " star" :" stars")
//
//            }.frame(height: 50)
//        }
//        .padding(.horizontal)
//    }
//}
