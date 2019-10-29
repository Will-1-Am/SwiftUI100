//
//  Flag.swift
//  Project06 3C GuessTheFlag
//
//  Created by William Spanfelner on 28/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct Flag: View {
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct Flag_Previews: PreviewProvider {
    static var previews: some View {
        Flag(image: "italy")
    }
}
