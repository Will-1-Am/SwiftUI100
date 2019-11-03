//: [Previous](@previous)
//:[Archiving Swift objects with Codable](https://www.hackingwithswift.com/books/ios-swiftui/archiving-swift-objects-with-codable)

/*
 Codable: a protocol specifically for archiving and unarchiving data, which is a fancy way of saying “converting objects into plain text and back again.”
 */
import SwiftUI
import PlaygroundSupport

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State var user = User(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
