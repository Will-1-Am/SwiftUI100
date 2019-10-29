//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        print(animationAmount)
        
        return VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
            
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
