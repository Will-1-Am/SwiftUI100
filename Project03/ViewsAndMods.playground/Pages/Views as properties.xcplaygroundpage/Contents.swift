//: [Previous](@previous)

//:[Views as properties](https://www.hackingwithswift.com/books/ios-swiftui/views-as-properties)

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    // Views can be declared as properties where modifiers can be added
    let motto1 = Text("Draco dormiens")
        .foregroundColor(.red)
    // Modifiers can also be added in the body
    let motto2 = Text("nunquam titillandus")
    var motto3: some View { Text("Draco dormiens") }
    
    var body: some View {
        VStack {
            motto1
            
            motto2
            .foregroundColor(.blue)
            
            motto3
        }
    }
}


let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
