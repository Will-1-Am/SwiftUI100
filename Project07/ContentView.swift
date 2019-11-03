//
//  ContentView.swift
//  iExpense
//
//  Created by William Spanfelner on 29/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    /*
     MARK: @ObservedObject is required here since expense information needs to be shared across views and needs to remain consistent.  A class is required to achieve this goal, since the unique instances of a struct will result in different data stores for each instantiation.  To allow the ContentView to update in respect of changes in data held by the Expenses class, the Expenses class must conform to ObservableObject and have an @Published property to emmit changes - in this case to the items property that is an array of ExpenseItems.
     
     MARK: @State showingAddExpense drives the sheet that will allow the user to add an expense
     */
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                //: MARK: Identifiable - since the protocol is in place in the Expenses struct and manages the unique ids for each ExpenseItem entry, the ForEach parameter list can be shortened as below.
                ForEach(expenses.items) { item in
                    //                    ForEach(expenses.items, id: \.id) { item in
                    //                        Text(item.name)
                    //                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("€\(item.amount)")
                    }
                    //MARK: .onDelete(perform:) together with the removeItems function permit the swipe gesture to reveal an option to delete.
                }.onDelete(perform: removeItems)
                
                // MARK: .sheet(isPresented:) is driven by the showingAddExpense state variable.  When the variable is true the sheet (the AddView view) slides in from the bottom. showingAddExpense is flipped by the navigationBarItem button "+" image.
            }.sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
             
                
            }.navigationBarItems(trailing:
                
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
