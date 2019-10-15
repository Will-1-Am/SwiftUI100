//
//  ContentView.swift
//  GuessTheFlag - a guessing game that helps users learn some of the many flags of the world.
//  Challenge 1 - Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert.
//
//  Created by William Spanfelner on 13/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //Challenge 1 - Add an @State property for the score
    @State private var score: Int = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
//            Color.blue.edgesIgnoringSafeArea(.all)
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
                        Image(self.countries[number].lowercased())
                            //MARK: .renderingMode(.original) modifier tells SwiftUI to render the original image pixels rather than trying to recolor them as a button.
                            .renderingMode(.original)
                            //MARK: .clipShape modifier clips a view to a specified shape (Capsule(), Circle(), Ellipse(), Rectangle(), RoundedRectangle(), etc. & these can be combined with an overlay of a different shape)
                            .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
            }
        }
        //Challenge 1 - Display the score in the alert
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
                })
        }

    }
    
    //MARK: What to do when a flag button is tapped - check whether the selection is correct and show the score alert
    //Challenge 1 - increment the score for a correct selection
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    //MARK: Triggered when the alert "continue" button is tapped - shuffles the array of countries and chooses the next "question's" correctAnswer
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
