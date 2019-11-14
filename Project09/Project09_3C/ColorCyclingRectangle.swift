//
//  ColorCyclingRectangle.swift
//  Drawing Project09 3C
//
//  Created by William Spanfelner on 08/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//
//  Project09 Challenge 3 - Create a ColorCyclingRectangle shape that is the rectangular cousin of ColorCyclingCircle, allowing us to control the position of the gradient using a property.

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                .inset(by: CGFloat(value))
                .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                    self.color(for: value, brightness: 1),
                    self.color(for: value, brightness: 0.5)
                ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
    .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangle()
    }
}
