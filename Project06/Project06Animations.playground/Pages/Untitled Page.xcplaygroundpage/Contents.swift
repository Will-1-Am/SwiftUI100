//: [Previous](@previous)

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var rotationAmount = 0.0
    @State private var buttonTapped = 0
    
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
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number].lowercased())
                        .renderingMode(.original)
                        .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 2)
                        .rotation3DEffect(.degrees(self.rotationAmount), axis: (x: 0, y: 1, z: 0))
                            
//                            .opacity(self.correctAnswer != number ? 0.25 : 1)
                    }.animation(self.correctAnswer == number ? .default : .none)
                }
                
//                Button(action: {
//                    self.buttonNum = 0
//                    self.flagTapped(self.buttonNum)
//                }) {
//                    Image(self.countries[0].lowercased())
//                    .renderingMode(.original)
//                    .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
//                    .shadow(color: .black, radius: 2)
//                    .rotation3DEffect(.degrees(self.spinButton ? self.rotationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
//
//                }.animation(buttonNum == 0 && buttonNum == correctAnswer ? .default : .none )
//
//                Button(action: {
//                    self.buttonNum = 1
//                    self.flagTapped(self.buttonNum)
//                }) {
//                    Image(self.countries[1].lowercased())
//                    .renderingMode(.original)
//                    .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
//                    .shadow(color: .black, radius: 2)
//                    .rotation3DEffect(.degrees(self.spinButton ? self.rotationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
//                }.animation(buttonNum == 1 && buttonNum == correctAnswer ? .default : .none )
//
//                Button(action: {
//                    self.buttonNum = 2
//                    self.flagTapped(self.buttonNum)
//                }) {
//                    Image(self.countries[2].lowercased())
//                    .renderingMode(.original)
//                    .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
//                    .shadow(color: .black, radius: 2)
//                    .rotation3DEffect(.degrees(self.spinButton ? self.rotationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
//
//                }.animation(buttonNum == 0 && buttonNum == correctAnswer ? .default : .none )
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
                })
        }//.opacity(0.5) setting opacity here sets opacity for the entire view rather than just the alert.

    }
    
    //MARK: What to do when a flag button is tapped - check whether the selection is correct and show the score alert
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            self.buttonTapped = number
            scoreTitle = "Correct"
            withAnimation {
                self.rotationAmount += 360
            }
        } else {
            scoreTitle = "Wrong"
        }
        print(scoreTitle)
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

//: [Next](@next)
