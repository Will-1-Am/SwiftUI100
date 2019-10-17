//: [Previous](@previous)

//: [Custom modifiers](https://www.hackingwithswift.com/books/ios-swiftui/custom-modifiers)

import SwiftUI
import PlaygroundSupport

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

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

// Custom modifiers can be used for so much more.  Remember, modifiers return new objects rather than modifying existing ones, so we could create one that embeds the view in a stack and adds another view:

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
        
    }
}



// With the extension in place above the ContentView struct can be rewritten as follows:
struct ContentView: View {
    var body: some View {
        ZStack{
            Color.orange
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")
            
            VStack {
                
                Text("Hello World")
                    .titleStyle()
            }
            
        }
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host


//: [Next](@next)
