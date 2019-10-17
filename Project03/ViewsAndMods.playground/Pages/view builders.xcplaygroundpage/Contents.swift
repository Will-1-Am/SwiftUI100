//: [Previous](@previous)

//:[Custom containers](https://www.hackingwithswift.com/books/ios-swiftui/custom-containers)

import SwiftUI
import PlaygroundSupport

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping(Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
    
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
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R \(row), C \(col)")
        }
    }
}

    
let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host



//: [Next](@next)
