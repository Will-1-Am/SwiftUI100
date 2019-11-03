//
//  AddView.swift
//  iExpense
//
//  Created by William Spanfelner on 30/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    //Challeng 2 - add a state property for the element position in the expense category color array
    @State private var category: Int? //= 0
    @Environment(\.presentationMode) var presentationMode
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    //Challenge 2 - decide which color code should be applied depending on actualAmount of expense
                    if actualAmount > 99 {
                        self.category = 2
                    } else if actualAmount > 9 {
                        self.category = 1
                    }

                    //Challenge 2 - use nil-coalescing to set the default color code
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount, amountCategory: self.category ?? 0)
//                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
