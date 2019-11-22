//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by William Spanfelner on 12/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section{
                TextField("Name:", text: $order.name)
                TextField("Street Address:", text: $order.streetAddress)
                TextField("City:", text: $order.city)
                TextField("Zip:", text: $order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }.disabled(order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
        .environment(\.colorScheme, .dark)
    }
}
