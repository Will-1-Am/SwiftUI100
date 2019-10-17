//
//  ContentView.swift
//  GuessTheFlag - a guessing game that helps users learn some of the many flags of the world.
//  Project 3 Challenge 3 - Go back to project 2 and create a FlagImage() view that renders one flag image using the specific set of modifiers we had.
//
//  Created by William Spanfelner on 13/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

// Project03 Challenge 3 - Create a struct for the FlagImage view with the desired mods
struct FlagImage: View {
    let image: String
    
    var body: some View {
        Image(image)
        .renderingMode(.original)
        .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
}


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
// Project03 Challenge 3 - create an instance of a FlagImage - this replaces the commented code below and removes some complexity from the body.
                            FlagImage(image: self.countries[number].lowercased())

                        //Image(self.countries[number].lowercased())
                        //    .renderingMode(.original)
                        //    .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        //    .shadow(color: .black, radius: 2)
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
