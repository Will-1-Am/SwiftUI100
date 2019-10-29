//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1

    ////                        .animation(.easeOut)
    ////        .animation(.interpolatingSpring(stiffness: 50, damping: 1)
    
    
//    var body: some View {
//        Button("Tap Me") {
//            self.animationAmount += 1
//        }
//        .padding(50)
//        .background(Color.red)
//        .clipShape(Circle())
//        .scaleEffect(animationAmount)
//        .animation(.default)
//    }
    
    
    
    //: The animation coded below grows the button diameter with ever tap
    var body: some View {
        Button("Tap Me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.easeInOut(duration: 2))
    }
    
    
    //: When using the .easeInOut modifier a new instance of a struct is created with its own modifiers so a dely or a repeatCount can be added
//    var body: some View {
//        Button("Tap Me") {
//            self.animationAmount += 1
//        }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .scaleEffect(animationAmount)
//        .animation(Animation.easeInOut(duration: 2).delay(1))
//    }

//: A repeatCount modifier adds a repetition to the animation, but if the reps specified do not match the state the animation will appear jumpy as the button will match the actual state.  Change the repeatCount parameter from 2 to 3 and see the difference.
//    var body: some View {
//        Button("Tap Me") {
//            self.animationAmount += 1
//        }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .scaleEffect(animationAmount)
//        .animation(Animation.easeInOut(duration: 2).repeatCount(2, autoreverses: true))
//    }
    
    
    // For a continuous animation the .repeatForever modifier can be employed
//    var body: some View {
//        Button("Tap Me") {
//            self.animationAmount += 1
//        }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .scaleEffect(animationAmount)
//        .animation(Animation.easeInOut(duration: 1)
//        .repeatForever(autoreverses: true))
//    }
//

        
    
    
    
//    var body: some View {
//        Button("Tap Me") {
//            //            self.animationAmount += 1
//        }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .overlay(
//            Circle()
//                .stroke(Color.red)
//                .scaleEffect(animationAmount)
//                .opacity(Double(2 - animationAmount))
//                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false))
//        )
//            .onAppear {
//                self.animationAmount = 2
//        }
//    }
    
    
    
////        .scaleEffect(animationAmount)
//            //        .animation(.default)
//            //        .animation(.easeOut)
////    .animation(.interpolatingSpring(stiffness: 50, damping: 1))
//

}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
