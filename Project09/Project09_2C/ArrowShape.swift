//
//  ArrowShape.swift
//  Drawing - Project09 Challenge 1 - Create an Arrow shape made from a rectangle and a triangle – having it point straight up is fine.
//
//  Created by William Spanfelner on 08/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//
// Challenge 1 - Create a new ArrowShape struct using the SwiftUI.View template
import SwiftUI

struct ArrowShape: Shape {
    // Challenge 1 - Conform to the Shape protocol with the path(in rect:) method and construct a path for the desired shape, by using CGRect properties for reproducability.
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addRect(CGRect(x: rect.maxX / 4, y: rect.midY, width: rect.maxX / 2 , height: rect.maxY / 2))
        
        return path
    }
}

struct ArrowShape_Previews: PreviewProvider {
    static var previews: some View {
        ArrowShape()
    }
}
