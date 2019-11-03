//
//  DeletingItems.swift
//  iExpense
//
//  Created by William Spanfelner on 29/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//
// [Deleting items using onDelete()](https://www.hackingwithswift.com/books/ios-swiftui/deleting-items-using-ondelete)
import SwiftUI

//struct DeletingItems: View {
//    @State var numbers = [Int]()
//    @State var currentNumber = 1
//
//    var body: some View {
//        VStack {
//            List {
//                ForEach(numbers, id: \.self) {
//                    Text("\($0)")
//                }
//            .onDelete(perform: removeRows)
//            }
//            Button("Add number") {
//                self.numbers.append(self.currentNumber)
//                self.currentNumber += 1
//            }
//        }
//    }
//
//    func removeRows(at offSets: IndexSet) {
//        numbers.remove(atOffsets: offSets)
//    }
//}

//: The above code works great if only single item are to be deleted.  If more items are necessary an edit/done feature is required…
struct DeletingItems: View {
    @State var numbers = [Int]()
    @State var currentNumber = 1
    
    var body: some View {
        NavigationView {
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
            }.navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offSets: IndexSet) {
        numbers.remove(atOffsets: offSets)
    }
}
struct DeletingItems_Previews: PreviewProvider {
    static var previews: some View {
        DeletingItems()
    }
}
