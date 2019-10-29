//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct ButtonView: View {
    //    var rotationAmount: CGFloat
    @State private var animationAmount: CGFloat = 1
    @State private var isCorrect = true
    
    var body: some View {
        Button("Tap Me") {
            self.flagTapped
            withAnimation {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(Double(animationAmount)), axis: (x: 0, y: isCorrect ? 1 : 0, z: 0) )
        
    }
    
    func flagTapped() {
        
    }

}


struct ContentView: View {
//    @State private var animationAmount: CGFloat = 1
    var body: some View {
        
        VStack {
            ForEach(0..<3) {_ in
                ButtonView()
            }
        }
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host


//: [Next](@next)
