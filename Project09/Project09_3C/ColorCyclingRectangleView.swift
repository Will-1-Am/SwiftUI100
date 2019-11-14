//
//  ColorCyclingRectangleView.swift
//  Drawing Project09 3C
//
//  Created by William Spanfelner on 08/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ColorCyclingRectangleView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: amount)
            
            Slider(value: $amount)
        }
    }
}

struct ColorCyclingRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleView()
    }
}
