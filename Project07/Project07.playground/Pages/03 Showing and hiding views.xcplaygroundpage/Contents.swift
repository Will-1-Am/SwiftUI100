//: [Previous](@previous)

//:[Showing and hiding views](https://www.hackingwithswift.com/books/ios-swiftui/showing-and-hiding-views)

//: NOTE: This code crashed Playground but will run on an Xcode canvas in a normal project.

//: a sheet: a new view presented on top of our existing one
import SwiftUI
import PlaygroundSupport

struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
}

struct ContentView: View {
    // To show the sheet a state var is required
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            //show the sheet by toggling the showingSheet state
            self.showingSheet.toggle()
        } //like an alert the sheet modifier is used to  show the sheet
        .sheet(isPresented: $showingSheet) {
            //contents of sheet
            SecondView()
        }
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
