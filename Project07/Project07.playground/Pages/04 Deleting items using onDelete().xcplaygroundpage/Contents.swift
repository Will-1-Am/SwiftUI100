//: [Previous](@previous)
//: [Deleting items using onDelete()](https://www.hackingwithswift.com/books/ios-swiftui/deleting-items-using-ondelete)

/*
 SwiftUI gives us the onDelete() modifier for us to use to control how objects should be deleted from a collection. In practice, this is almost exclusively used with List and ForEach: we create a list of rows that are shown using ForEach, then attach onDelete() to that ForEach so the user can remove rows they don’t want.
 
 NOTE: This playground page must be run in an Xcode project, otherwise crashey crashey
 */

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State var numbers = [Int]()
    @State var currentNumber = 1
    
    var body: some View {
        VStack {
            List {
                ForEach(numbers, id: \.self) {
                    Text("\($0)")
                }
            .onDelete(perform: removeRows)
            }
            Button("Add number") {
                self.numbers.append(self.currentNumber)
                self.currentNumber += 1
            }
        }
    }
    
    func removeRows(at offSets: IndexSet) {
        numbers.remove(atOffsets: offSets)
    }
}

let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host

//: [Next](@next)
