//: [Previous](@previous)
//: [What is behind the main SwiftUI view?](https://www.hackingwithswift.com/books/ios-swiftui/what-is-behind-the-main-swiftui-view)


import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //Using maxWidth and maxHeight is different from using width and height – we’re not saying the text view must take up all that space, only that it can. If you have other views around, SwiftUI will make sure they all get enough space.
            .background(Color.red)
            //background modifications only affect the immediate object's default bounds, while adding the fram modifier expands the influence to the extents of the safe area
            .edgesIgnoringSafeArea(.all)
        // edgesIgnoringSafeArea(.all) together with the frame modifier will extend the background to the extents of the device area.
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
