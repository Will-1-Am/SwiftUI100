//: [Previous](@previous)

//:[Custom containers](https://www.hackingwithswift.com/books/ios-swiftui/custom-containers)

//: Make a new type of stack called a GridStack, which will let us create any number of views inside a grid.

import SwiftUI
import PlaygroundSupport

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}


struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) {
            row, col in
//            Text("R \(row), C \(col)")
            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R \(row), C \(col)")
            }
        }
    }
}


let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
