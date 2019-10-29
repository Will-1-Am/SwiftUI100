//: [Previous](@previous)
//[Animating gestures](https://www.hackingwithswift.com/books/ios-swiftui/animating-gestures)

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    //Second, we need a state to control
    @State private var dragAmount = CGSize.zero
   
//    var body: some View {
//        //First we draw an object on the screen
//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        // MARK: offset and dragAmount will allow the repositioning of the rounded rectangle on the screen
//        .offset(dragAmount)
//
//        // MARK: gesture & DragGesture is used to monitor the distance the rectangle is dragged from the center
//        .gesture(DragGesture()
//            .onChanged { self.dragAmount = $0.translation }
//            .onEnded { _ in self.dragAmount = .zero }
//        )
//
//        //Animate implicitly the drag and release
//            .animation(.spring())
//    }
    
    
//    var body: some View {
//        //First we draw an object on the screen
//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            // MARK: offset and dragAmount will allow the repositioning of the rounded rectangle on the screen
//            .offset(dragAmount)
//
//            // MARK: gesture & DragGesture is used to monitor the distance the rectangle is dragged from the center
//            .gesture(DragGesture()
//                .onChanged { self.dragAmount = $0.translation }
//
//                //Animate explicitly on release
//                .onEnded { _ in
//                    withAnimation(.spring()) {
//                        self.dragAmount = .zero }
//                }
//        )
//    }
    
    
    
    /*
     If we combine offset animations with drag gestures and a little delay, we can create remarkably fun animations without a lot of code.

    To demonstrate this, we could write the text “Hello SwiftUI” as a series of individual letters, each one with a background color and offset that is controlled by some state. Strings are just slightly fancy arrays of characters, so we can get a real array from a string like this: Array("Hello SwiftUI").
     */
    
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                }
        )
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
