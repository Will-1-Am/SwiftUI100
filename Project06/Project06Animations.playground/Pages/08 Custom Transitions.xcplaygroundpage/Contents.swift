//: [Previous](@previous)
//: [Building custom transitions using ViewModifier](https://www.hackingwithswift.com/books/ios-swiftui/building-custom-transitions-using-viewmodifier)

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                   self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
//                    .transition(.asymmetric(
//                        insertion: .scale,
//                        removal: .opacity
//                        )
//                )
            }
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
        //        clipped() means that when the view rotates, the parts lying outside its natural rectangle don’t get drawn.
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
