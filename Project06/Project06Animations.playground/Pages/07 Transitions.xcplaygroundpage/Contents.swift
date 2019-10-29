//: [Previous](@previous)

//: [Showing and hiding views with transitions](https://www.hackingwithswift.com/books/ios-swiftui/showing-and-hiding-views-with-transitions)

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var isShowingRed = false
// The code to show a red rectangle when the Tap Me button is tapped - without animation
//    var body: some View {
//        VStack {
//            Button("Tap Me") {
//                self.isShowingRed.toggle()
//            }
//
//            if isShowingRed {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 200, height: 200)
//            }
//        }
//    }
    
    
//    // The code to show a red rectangle when the Tap Me button is tapped - with animation
//    var body: some View {
//        VStack {
//            Button("Tap Me") {
//                withAnimation {
//                   self.isShowingRed.toggle()
//                }
//            }
//
//            if isShowingRed {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 200, height: 200)
//            }
//        }
//    }
    
    
//    // Using a transition the retangle can be scaled up and down
//    var body: some View {
//        VStack {
//            Button("Tap Me") {
//                withAnimation {
//                   self.isShowingRed.toggle()
//                }
//            }
//
//            if isShowingRed {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.scale)
//            }
//        }
//    }
    
    
    // Using a transition the retangle can be scaled when an object is inserted and can be combined with a different transition when the object is removed
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                   self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(
                        insertion: .scale,
                        removal: .opacity
                        )
                )
            }
        }
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
