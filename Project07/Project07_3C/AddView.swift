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
    @Environment(\.presentationMode) var presentationMode
    //MARK: Challenge 3 - Create a state variable for the case where a user enters an amount that cannot be converted to an integer.
    @State private var amountError = false
    
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
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    //MARK: Challenge 3 - flip the amountError state boolean since the optional binding failed
                    self.amountError = true
                }
            })
        }
        //MARK: Challenge 3 - Show and explain the error
        .alert(isPresented: $amountError) {
            Alert(title: Text("Entry not possible"), message: Text("The amount entered must be a number without decimal places (e.g. 7). Please enter the amount again."), dismissButton: .default(Text("Continue")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
