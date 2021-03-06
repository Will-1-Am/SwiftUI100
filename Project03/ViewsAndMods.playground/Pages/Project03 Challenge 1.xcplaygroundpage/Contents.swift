//: [Previous](@previous)
//
//:  Project03 Challenge 1 - Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.
//
//: [Views and modifiers: Wrap up](https://www.hackingwithswift.com/books/ios-swiftui/views-and-modifiers-wrap-up)

import SwiftUI
import PlaygroundSupport

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, playground")
        .titleStyle()
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host


//: [Next](@next)
