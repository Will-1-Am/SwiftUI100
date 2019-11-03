//
//  ContentView.swift
//  iExpense - Project07 Challenge 3 - Add some validation to the Save button in AddView. If you enter “fish” or another thing that can’t be converted to an integer, show an alert telling users what the problem is.
//
//  Created by William Spanfelner on 29/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                //: MARK: Identifiable - since the protocol is in place in the Expenses struct, the ForEach parameter list can be shorted as below.
                ForEach(expenses.items) { item in
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("€\(item.amount)")
                    }
                }
                    //                    ForEach(expenses.items, id: \.id) { item in
                    //                        Text(item.name)
                    //                    }
                    .onDelete(perform: removeItems)
                
            }.sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
                
            }
            .navigationBarItems(trailing:
                
                Button(action: {
                    self.showingAddExpense = true
                    //The following two lines will enter test expenses
                    //                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    //                    self.expenses.items.append(expense)
                }) {
                    Image(systemName: "plus")
                }
            )
                .navigationBarTitle("iExpense")
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
