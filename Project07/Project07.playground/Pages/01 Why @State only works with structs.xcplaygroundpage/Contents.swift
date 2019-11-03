//: [Previous](@previous)

//:[Why @State only works with structs](https://www.hackingwithswift.com/books/ios-swiftui/why-state-only-works-with-structs)

import SwiftUI
import PlaygroundSupport

//: Create a struct to store username information
//struct User {
//    var firstName = "William"
//    var lastName = "Harry"
//}
///*
// Create the view using the state properties in the User struct.
//
// Note: every struct has a unique owner meaning that if two views use a single struct as a information source, the two views will actually have separate unique copies of the source struct.
//
// This behaviour differs with classes in that classes share their instances across multiple end-points.
// */
//struct ContentView: View {
//    @State private var user = User()
//
//    var body: some View {
//        VStack {
//            Text("Your name is: \(user.firstName) \(user.lastName)")
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//        }
//    }
//}


//: Changing the User struct in the code above to a class
class User {
    var firstName = "William"
    var lastName = "Harry"
}
/*
 @State properties are used to watch for changes, and a new instance of a struct is created with each change.  Swift can only modify the value directly in the class and thereby losing the ability to reload the view. @State cannot see that the property value has changed. The text view will not update despite the fact that the TextFields can be edited.
 @ObservedObject & @EnvironmentObject will fix this issue...
 */
struct ContentView: View {
    @State private var user = User()

    var body: some View {
        VStack {
            Text("Your name is: \(user.firstName) \(user.lastName)")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}
let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host


//: [Next](@next)
