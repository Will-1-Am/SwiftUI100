
//: [Why modifier order matters](https://www.hackingwithswift.com/books/ios-swiftui/why-modifier-order-matters)


import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    
    @State private var useRedText = false
    
    var body: some View {
        VStack {
            Button("Hello World") {
                print(type(of: self.body))
                self.useRedText.toggle()
            }
            .font(.largeTitle)
            .foregroundColor(useRedText ? .red : .blue)
            .frame(width: 200, height: 200)
            .background(Color.yellow)
            
            Spacer()
            
            Text("Hello World")
            .blur(radius: 0)
            .padding()
                .background(Color.red)
            .padding()
                .background(Color.blue)
            .padding()
                .background(Color.green)
            .padding()
                .background(Color.yellow)
            
            Spacer()
            Text("Hello World")
            .padding()
                .background(Color.red)
            .padding()
                .background(Color.blue)
            .padding()
                .background(Color.green)
            .padding()
                .background(Color.yellow)
            
        }
        .font(.title)
    .blur(radius: 5)
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host
