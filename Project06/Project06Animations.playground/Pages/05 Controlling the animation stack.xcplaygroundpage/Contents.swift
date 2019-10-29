//: [Previous](@previous)

/*
 That’s concept one: modifier order matters, because SwiftUI wraps views with modifiers in the order they are applied.
 
 Concept two is that we can apply an animation() modifier to a view in order to have it implicitly animate changes.
 [Controlling the animation stack](https://www.hackingwithswift.com/books/ios-swiftui/controlling-the-animation-stack)
 */

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var animationAmount = 0.0
    //To modify the button to show different colors depending upon some state, first define a state:
    @State private var enabled = false
    
//    var body: some View {
//        Button("Tap Me") {
//
//            //Toggle the enabled state when the button is tapped
//            self.enabled.toggle()
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                self.animationAmount += 360
//            }
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? Color.red : Color.blue)
//        .foregroundColor(.white)
//        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0) )
//        //Add the animation modifier to execute the changes
//        .animation(.default)
//    }
//
    
   //: You can attach the animation() modifier several times, and the order in which you use it matters.
//    var body: some View {
//        Button("Tap Me") {
//
//            //Toggle the enabled state when the button is tapped
//            self.enabled.toggle()
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                self.animationAmount += 360
//            }
//        }
//        .frame(width: 200, height: 200)
//        //Conditionally apply color depending on the enabled state
//        .background(enabled ? Color.red : Color.blue)
//        .foregroundColor(.white)
////        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0) )
//        //Add the animation modifier to execute the changes
//        .animation(.default)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//    }
    
    // Moving the clipShape modifier in front of the animation modifier has the effect of animating the rounding of the corners.
//    var body: some View {
//        Button("Tap Me") {
//
//            //Toggle the enabled state when the button is tapped
//            self.enabled.toggle()
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                self.animationAmount += 360
//            }
//        }
//        .frame(width: 200, height: 200)
//            //Conditionally apply color depending on the enabled state
//        .background(enabled ? Color.red : Color.blue)
//        .foregroundColor(.white)
////.rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0) )
//
//            //Add the animation modifier to execute the changes
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.default)
//    }
    
    
    //Now for the fun part: if we apply multiple animation() modifiers, each one controls everything before it up to the next animation.
//    var body: some View {
//        Button("Tap Me") {
//
//            //Toggle the enabled state when the button is tapped
//            self.enabled.toggle()
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                self.animationAmount += 360
//            }
//        }
//        .frame(width: 200, height: 200)
//            //Conditionally apply color depending on the enabled state
//            .background(enabled ? Color.red : Color.blue)
//            .animation(.default)
//            .foregroundColor(.white)
//            //.rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0) )
//
//            //Add the animation modifier to execute the changes
//            .clipShape(RoundedRectangle(
//                cornerRadius: enabled ? 60 : 0))
//            .animation(.interpolatingSpring(
//                stiffness: 10, damping: 1))
//    }


// Animations can also be applied partially e.g. you may wish to apply the effect over the latter half of the modifiers - after the .animation(nil) mod
    var body: some View {
        Button("Tap Me") {
            
            //Toggle the enabled state when the button is tapped
            self.enabled.toggle()
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .frame(width: 200, height: 200)
            //Conditionally apply color depending on the enabled state
            .background(enabled ? Color.red : Color.blue)
            .animation(nil)
            .foregroundColor(.white)
//            .rotation3DEffect(
//                .degrees(animationAmount),
//                  axis: (x: 0, y: 1, z: 0) )
            
            //Add the animation modifier to execute the changes
            .clipShape(RoundedRectangle(
                cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(
                stiffness: 10, damping: 1))
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
