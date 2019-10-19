//
//  ContentView.swift
/*
 RockPaperScissors Project01-03 Milestone Challenge - Make a brain training game that challenges players to win or lose at rock, paper, scissors.

So, very roughly:

- Each turn of the game the app will randomly pick either rock, paper, or scissors.
- Each turn the app will either prompt the player to win or lose.
- The player must then tap the correct move to win or lose the game.
- If they are correct they score a point; otherwise they lose a point.
- The game ends after 10 questions, at which point their score is shown.
So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.
*/
//  Created by William Spanfelner on 18/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//: [Challenge](https://www.hackingwithswift.com/guide/ios-swiftui/2/3/challenge)

import SwiftUI

struct ContentView: View {
    let moves = ["🎸", "🧻", "✂️"] //["Rock", "Paper", "Scissors"]

    @State private var userChoice: Int = 1
    @State private var userToWin = true
    @State private var cChoice: Int = 1
    
    @State private var score = 0
    @State private var round: Int = 0
    @State private var roundOutcome = "Draw"
    
    
    var body: some View {
        NavigationView {
            VStack {
                Section(header: Text("Make your selection:")) {
                    HStack {
                        Spacer()
                        Toggle("Will you Win or Lose?", isOn: $userToWin)
                        Spacer()
                    }

                    Section(header: Text("Choose Rock, Paper or Scissors:")) {
                        HStack {
                            Spacer()
                            
                            ForEach(0 ..< moves.count) { number in
                                Button(action: {
                                    self.moveSelection(number)
                                }) {
                                    Text(self.moves[number])
                                        .font(.system(size: 80))
                                }
                                
                                Spacer()
                            }
                        }
                    }
                }
                
                Spacer()
                Text("User chose: ")
                Text(userChoice < 3 ? "\(moves[userChoice]), \(userToWin ? "Win" : "Lose")" : "Choices incomplete")
                    .font(.largeTitle)
                
                Spacer()
                
                Section(header: Text("Computer chose:")) {
                    Text("\(moves[cChoice])" )
                        .font(.system(size: 60))
                }

                Spacer()
                
                Section(header: Text("Game result:")) {
                    VStack {
                        Text(roundOutcome)
                        Text(round <= 10 ? "Round \(round) of 10" : "GAME OVER" )
                        Text("Score: \(score)")
                    }.font(.headline)
                }
                
                Spacer()
            }
            .navigationBarTitle("Rock, Paper, Scissors")
        }
    }
    
    func endGame() {
        //disable buttons here
    }
    
    func moveSelection(_ number: Int) {
        round += 1
        if round > 10 {
            endGame()
        }
        userChoice = number
        cChoice = Int.random(in: 0 ... 2)
        
        var preliminaryResult = false
        
        guard moves[userChoice] != moves[cChoice] else {
            roundOutcome = "Draw"
            return
        }
        
        switch userChoice{
        case 0:
            preliminaryResult = cChoice == 1 ? false : true
        case 1:
            preliminaryResult = cChoice == 2 ? false : true
        default:
             preliminaryResult = cChoice == 0 ? false : true
        }
        
        if preliminaryResult == true && userToWin {
            roundOutcome = "Win"
            score += 1
        } else if preliminaryResult == true && !userToWin {
            roundOutcome = "Lose"
            score -= 1
        } else if preliminaryResult == false && !userToWin {
            roundOutcome = "Win"
            score += 1
        } else {
            roundOutcome = "Lose"
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
