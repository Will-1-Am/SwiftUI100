//
//  ContentView.swift
//  iExpense - Project07 Challenge 2 - Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.
//
//  Created by William Spanfelner on 29/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    // Challenge 2 Create an array of colors for the different expense categories (ie < $10, < $100, >$100)
    let categoryColors: [Color] = [.green, .orange, .red]
    let categoryFontWeight: [Font.Weight] = [.medium, .black, .heavy]
    
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
                            //Challenge 2 - add the style modification for the expense category
                            .fontWeight(self.categoryFontWeight[item.amountCategory])
                            .foregroundColor(self.categoryColors[item.amountCategory])
                    }
                }
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
