//: [Previous](@previous)

//: [Custom modifiers](https://www.hackingwithswift.com/books/ios-swiftui/custom-modifiers)

import SwiftUI
import PlaygroundSupport


// Custom modifiers can be created to embody a set of mods where the modifier conforms to the ViewModifier protocol
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// Create an extension to the View protocol for convenience in accessing the mod elsewhere in code.
extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}


//struct ContentView: View {
//    var body: some View {
//        Text("Hello World")
//        .modifier(Title())
//    }
//}

// With the extension in place above the ContentView struct can be rewritten as follows:
struct ContentView: View {
    var body: some View {
        Text("Hello World")
        .titleStyle()
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host


//: [Next](@next)
