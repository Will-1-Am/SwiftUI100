//
//  CodableConformancePublished.swift
//  CupcakeCorner
//
//  Created by William Spanfelner on 11/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct CodableConformancePublished: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

class User: ObservableObject, Codable {
    // This code compiles.
//    var name = "Swift"
    /*
     MARK: @Published wraps the property in another type & provides addtional functionality and therefore requires special treatment.  Published is a struct that accepts any value type - it is a generic type. This means that in order to make @Published conform, Swift must know what type is inside.
     */
   @Published var name = "Swift"
    
    /*
     MARK: CodingKey can help to resolve the issue.
     */
    
    enum CodingKeys: CodingKey {
        case name
    }
    /*
     MARK: The properties now have to be read in using the following initializer:
     */
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    /*
     The required keyword indicates that the User class must be overridden if it is subclassed (use the final keyword instead to disallow subclassing;
     - the Decoder instance holds the data to decode;
     - Swift is then told where the keys to the data can be found (in this case an enum called CodingKeys);
     - The data is read from the keys in the container - the enum
     */
    
    /*
     And to fully conform to the Codable protocol, Swift needs to know how to encode data of this type. The encode function below accomplishes the task by essentially reversing that which the initializer does above.
     */
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct CodableConformancePublished_Previews: PreviewProvider {
    static var previews: some View {
        CodableConformancePublished()
        .environment(\.colorScheme, .dark)
    }
}
