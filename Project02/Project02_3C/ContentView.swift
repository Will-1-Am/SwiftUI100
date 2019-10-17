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
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var incorrectAnswer: Int?
    
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
                VStack {
                    Text("Your score is: \(score)")
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            //Challeng 3 - a switch determines best path to take regarding type of answer presented
            switch scoreTitle {
            case "Correct":
                return Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                    })
            default:
                return Alert(title: Text(scoreTitle), message: Text("Wrong! That’s the flag of \(getCountryName()). \nYour score is \(score)"), dismissButton: .default(Text("Continue")){
                    //Challeng 3 - prevent spurious reporting by resetting the incorrectAnswer property after presenting alert.
                    self.incorrectAnswer = nil
                    self.askQuestion()
                })
            }
        }
    }
    
    //Challeng 3 - getCountryName eliminates the visiblity issue that is created when a conditional unwrap or guard presents for the return statement
    func getCountryName() -> String {
        guard let chosenCountry = incorrectAnswer else { return "Unknown" }
        return countries[chosenCountry]
    }
    
    //MARK: What to do when a flag button is tapped - check whether the selection is correct and show the score alert
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            incorrectAnswer = number
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
