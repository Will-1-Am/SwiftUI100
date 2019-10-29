//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var isCorrect = false
    
    
    var body: some View {
        Button("Tap Me") {
            withAnimation {
                self.animationAmount += 360
            }
            //            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
            //                self.animationAmount += 360
            //            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0) )
        .animation(isCorrect ? .default : .none)
        .opacity(isCorrect ? 1.0 : 0.25)
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host


//: [Next](@next)
