//: [Previous](@previous)

//:[View composition](https://www.hackingwithswift.com/books/ios-swiftui/view-composition)

import SwiftUI
import PlaygroundSupport

//struct ContentView: View {
//    var body: some View {
//        VStack(spacing: 10) {
//            Text("First")
//                .font(.largeTitle)
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.blue)
//                .clipShape(Capsule())
//            Text("Second")
//                .font(.largeTitle)
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.blue)
//                .clipShape(Capsule())
//        }
//    }
//}
    
    
    // The above code is equivalent to the following where a separate struct object removes complexity from the body:
    
struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundColor(.white)
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)
        }
    }
}
    
    

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host


//: [Next](@next)
