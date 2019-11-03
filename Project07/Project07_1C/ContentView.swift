//
//  ContentView.swift
//  iExpense - Project07 Challenge 1 - Add an Edit/Done button to ContentView so users can delete rows more easily.
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
                    .onDelete(perform: removeItems)
                
            }.sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
                
            }
            // Challenge 1 - Intuitively, the EditButton would be added with the leading version of the navigationBarItems method, but they would appear to be mutually exclusive. .navigationBarItems(leading:, trailing:) must be used althought the simulator has a problem displaying the correct behaviour.  When tested on physical device everything worked spivingly.
                
//            .navigationBarItems(leading: EditButton())
            .navigationBarItems(leading: EditButton(), trailing:
//            .navigationBarItems(trailing:
                
                Button(action: {
                    self.showingAddExpense = true
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
