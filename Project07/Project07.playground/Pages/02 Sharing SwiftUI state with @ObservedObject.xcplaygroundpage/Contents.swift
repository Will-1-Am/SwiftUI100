//: [Previous](@previous)
//: [Sharing SwiftUI state with @ObservedObject](https://www.hackingwithswift.com/books/ios-swiftui/sharing-swiftui-state-with-observedobject)

import SwiftUI
import PlaygroundSupport

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}
/*
@Published is more or less half of @State: it tells Swift that whenever either of those two properties changes, it should send an announcement out to any SwiftUI views that are watching that they should reload.
 
 How do those views know which classes might send out these notifications? That’s another property wrapper, @ObservedObject, which is the other half of @State – it tells SwiftUI to watch a class for any change announcements.
 */
struct ContentView: View {
    @ObservedObject var user = User()

    var body: some View {
        VStack {
            Text("Your name is: \(user.firstName) \(user.lastName)")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

/*
 So there are three steps to sharing properties with an external object:

 - Make a class that conforms to the ObservableObject protocol.
 - Mark some properties with @Published so that any views using the class get updated when they change.
 - Create an instance of our class using the @ObservedObject property wrapper.
 */

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
