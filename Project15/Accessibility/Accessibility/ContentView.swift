//
//  ContentView.swift
//  Accessibility
//
//  Created by William Spanfelner on 06/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    @State private var estimate = 25.0
    
    var body: some View {
        ZStack {
            //MARK: When the decorative parameter name is used to call an image, VoiceOver will ignore it
            Image(decorative: pictures[selectedPicture])
                .resizable()
                .blur(radius: 12)
//                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                
                //MARK: The view is made completely invisible to accessibility with the following modifier:
                .accessibility(hidden: true)
            
            VStack {
                
                Image(self.pictures[self.selectedPicture])
                    .resizable()
                    .accessibility(label: Text(self.labels[self.selectedPicture]))
                    .accessibility(addTraits: .isButton)
                    .accessibility(removeTraits: .isImage)
                    .onTapGesture {
                        self.selectedPicture = Int.random(in: 0...3)
                    }

                StepperView()
                    .frame(height: CGFloat(45))
                    .padding(.horizontal)
                
                TextViews()

                Slider(value: $estimate, in: 0...50)
                    .padding(.horizontal)
                    //MARK: Accessibility will read out the values of the slider as percentages, but a better approach maybe to add the modifier as below.
                    .accessibility(value: Text("\(Int(estimate))"))
            }
            .scaledToFit()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
