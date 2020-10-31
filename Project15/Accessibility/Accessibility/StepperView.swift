//
//  StepperView.swift
//  Accessibility
//
//  Created by William Spanfelner on 06/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct StepperView: View {
    
    @State private var rating = 1
        
    var body: some View {
//        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
//            .padding(.horizontal)
//            .accessibility(value: Text("\(rating) out of 5"))
        //MARK: Adding a Form container allows the Stepper view to be separated so that the - + buttons may be used - but not always
//        Group {
            
        HStack {
            Text("Rate our service: ")
                .font(.headline)
            Stepper(value: $rating, in: 1...5) {

                Text(rating == 1 ? "\(rating) star out of 5" : "\(rating) stars out of 5")
//                Text("\(rating)/5")
//                            .accessibility(value: Text(rating == 1 ? "\(rating) star out of 5" : "\(rating) stars out of 5"))
            }
            
//            .accessibility(addTraits: .isButton)
//            .accessibility(label: Text("Rate our service: "))

            //            }
            //            .accessibilityElement(children: .combine)
            
        }
//        .accessibilityElement(children: .combine)

//    .opacity(0)
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView()
    }
}
