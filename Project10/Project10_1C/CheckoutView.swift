//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by William Spanfelner on 12/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    Text("Your order will be delivered to: \n\(self.order.name)\n \(self.order.streetAddress) \n\(self.order.city) \n\(self.order.zip)")
                    Button("Place Order") {
                        // place the order
                        self.placeOrder()
                    }
                .padding()
                }
            }
            //MARK: Display an Alert with the order data received
        }.alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .environment(\.colorScheme, .dark)
    }
    
    func placeOrder() {
        //MARK: Convert current order object to JSON format
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        //MARK: Prepare a URL request to send the JSON data using HTTP POST
        let url = URL(string: "https://reqres.in/api/cupcakes")! //MARK: https://reqres.in – it lets us send any data we want, and will automatically send it back
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        //MARK: Make the network request - remember to add .resume() at the end otherwise the session will never start
        URLSession.shared.dataTask(with: request) { data, response, error in
            //MARK: Ensure data is received otherwise show an error.
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
            
            
        }.resume()
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
        .environment(\.colorScheme, .dark)
    }
}
