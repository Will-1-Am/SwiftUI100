//
//  ContentView.swift
//  GuessTheFlag - a guessing game that helps users learn some of the many flags of the world.
//  Project06 Challenge 2 - When you tap the correct flag, make the other two buttons fade out to 25% opacity.
//
//  Created by William Spanfelner on 13/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var revolution = 0.0
    @State private var buttonTapped = 0
// MARK: Challenge 2 add a property for opacity and set it high
    @State private var opacity = 1.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        // flag was tapped
                        self.flagTapped(number)
                    }) {
                        Flag(image: self.countries[number].lowercased())
                    }.rotation3DEffect(.degrees(self.revolution), axis: (x: 0, y: self.correctAnswer == number ? 1 : 0, z: 0))
                        // MARK: Challenge 2 Apply conditional animation
                        .animation(Animation.easeOut).opacity(self.correctAnswer != number ? self.opacity : 1.0)
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
                })
        }
    }
    
    //MARK: What to do when a flag button is tapped - check whether the selection is correct and show the score alert
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            self.buttonTapped = number
            withAnimation {
                self.revolution += 360
                // MARK: Challenge 2 Set the opacity change to animate
                self.opacity -= 0.75
            }
            self.revolution = 0.0
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    //MARK: Triggered when the alert "continue" button is tapped - shuffles the array of countries and chooses the next "question's" correctAnswer
    func askQuestion() {
        // MARK: Challenge 2 Reset opacity
        self.opacity = 1.0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
