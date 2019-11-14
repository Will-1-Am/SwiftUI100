//
//  ArrowShapeView.swift
//  Drawing - Project09 Challenge 1 - Create an Arrow shape made from a rectangle and a triangle – having it point straight up is fine.
//
//  Created by William Spanfelner on 08/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//
// Challenge 1 - Create a view using an instance of the Arrow shape, providing a frame of specific dimensions and assign a foreground color.
import SwiftUI

struct ArrowShapeView: View {
    var body: some View {
        ArrowShape()
            .frame(width: 300, height: 300)
            .foregroundColor(Color.yellow)
    }
}

struct ArrowShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowShapeView()
    }
}
