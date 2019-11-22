//
//  Order.swift
//  CupcakeCorner
//
//  Created by William Spanfelner on 12/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation

class Order: ObservableObject, Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    /*
     MARK: @Published allows the class's properties to be available throughout the application, but it also removes automatic conformance to the Codable protocol.  Swift needs to know what and how to encode and decode the data as it will be submitted in JSON format.
     */
    
    //MARK: CodingKeys is a list of all the properties that need encoding
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    //MARK: encoding the properties with the keys.  encode throws and errors will propogate upwards
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    //MARK: dencoding with the required initializer - essentially the reverse of encoding
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    //MARK: the following empty initializer is required to setup just a plain old, empty order - without this initializer the required initializer would be used everywhere, but would fail in situations where no data is available like on app first start.
    init() { }
    
    @Published var type = 0
    @Published var quantity = 3
    
    //MARK: The property observer here ensures that the extras are always reflecting the correct state
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    //MARK: A computed property for basic address validation
    var hasValidAddress: Bool {
        
        // Challenge 1 - remove whitespace from string and check that it isn't empty
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
        streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
        city.trimmingCharacters(in: .whitespaces).isEmpty ||
        zip.trimmingCharacters(in: .whitespaces).isEmpty
        {
            return false
        }
        
        // The code above replaces the following validation
//        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
//            return false
//        }
        
        return true
    }
    
    //MARK: Computing the total order value
    var cost: Double {
        //$2 per cupcake
        var cost = Double(quantity) * 2
        
        //complicated cupcakes cost more
        cost += (Double(type) / 2)
        
        //$1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
}
