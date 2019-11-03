//: [Previous](@previous)
//: [Storing user settings with UserDefaults](https://www.hackingwithswift.com/books/ios-swiftui/storing-user-settings-with-userdefaults)

import SwiftUI
import PlaygroundSupport

/*
 As this is clearly A Very Important App, we want to save the number of taps that the user made, so when they come back to the app in the future they can pick up where they left off.
 */
struct ContentView: View {
//    @State var tapCount = 0
    // To read back the tapCount from UserDefaults
    @State var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    var body: some View {
        Button("Tap count: \(tapCount)") {
            self.tapCount += 1
            // First write the tapCount to UserDefaults
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host
//: [Next](@next)
