//
//  ContentView.swift
//  GuessTheFlag - a guessing game that helps users learn some of the many flags of the world.
//  Challenge 3 - When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
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
    
    //  Challenge 3 - Add a property to hold the incorrect answer element
    @State private var incorrectAnswer: Int?
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        /* */
                        // flag was tapped
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number].lowercased())
                            /* */
                            //MARK: .renderingMode(.original) modifier tells SwiftUI to render the original image pixels rather than trying to recolor them as a button.
                            .renderingMode(.original)
                            /* */
                            //MARK: .clipShape modifier clips a view to a specified shape (Capsule(), Circle(), Ellipse(), Rectangle(), RoundedRectangle(), etc. & these can be combined with an overlay of a different shape)
                            .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                //Challenge 2 - Add a text label directly below the flags for the player's current score
                Text("Your score is: \(score)" )
                
                Spacer()
            }
            .foregroundColor(.white)
        }
        //Challenge 1 - Display the score in the alert
        .alert(isPresented: $showingScore) {
            //Challenge 3 - a switch determines best path to take regarding type of answer presented
            //            switch scoreTitle {
            //            case "Correct":
            //                return Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
            //                    self.askQuestion()
            //                })
            //            case "Wrong":
            //                return Alert(title: Text(scoreTitle), message: Text("Wrong. That's the flag of \(countries[incorrectAnswer]). Your score is \(score)"), dismissButton: .default(Text("Continue")){
            //            self.incorrectAnswer = nil
            //            self.askQuestion()
            //        })
            //            }
            
            //Challenge 3 - If let will check whether the optional incorrect has a non-nil value, which will mean that an incorrect answer was submitted.
            if let incorrectAnswer = incorrectAnswer {
                return Alert(title: Text(scoreTitle), message: Text("Wrong. That's the flag of \(countries[incorrectAnswer]). Your score is \(score)"), dismissButton: .default(Text("Continue")){
                    self.incorrectAnswer = nil
                    self.askQuestion()
                })
            }
            return Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
        }
    }
    
    /* */
    //MARK: What to do when a flag button is tapped - check whether the selection is correct and show the score alert
    //Challenge 1 - increment the score for a correct selection
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            /* */
            //  Challenge 3 - Assign the number passed-in to the incorrectAnswer property
            incorrectAnswer = number
            scoreTitle = "Wrong"
            score -= 1
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
