//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

//struct SecondView: View {
//    var body: some View {
//        Text("Second View")
//    }
//}
//
//struct ContentView: View {
//    // To show the sheet a state var is required
//    @State private var showingSheet = false
//
//    var body: some View {
//        Button("Show Sheet") {
//            //show the sheet by toggling the showingSheet state
//            self.showingSheet.toggle()
//        } //like an alert the sheet modifier is used to  show the sheet
//        .sheet(isPresented: $showingSheet) {
//            //contents of sheet
//            SecondView()
//        }
//    }
//}

//: SecondView can be specified to work with a name property like this:

//struct SecondView: View {
//    var name: String
//
//    var body: some View {
//        Text("Hello \(name)")
//    }
//}
//
//struct ContentView: View {
//    // To show the sheet a state var is required
//    @State private var showingSheet = false
//
//    var body: some View {
//        Button("Show Sheet") {
//            //show the sheet by toggling the showingSheet state
//            self.showingSheet.toggle()
//        } //like an alert the sheet modifier is used to  show the sheet
//        .sheet(isPresented: $showingSheet) {
//            //contents of sheet
//            SecondView(name: "@twostraws")
//        }
//    }
//}



/*
 @Environment allows properties to be created that store values provided to us externally.
 
 The presentation mode of a view contains only two pieces of data, but both are useful: a property storing whether the view is currently presented on screen, and a method to let us dismiss the view immediately.
 */

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var name: String
    
    var body: some View {
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
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
            SecondView(name: "@twostraws")
        }
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
