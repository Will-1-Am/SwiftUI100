//
//  ArrowShapeView.swift
//  Drawing - Project09 Challenge 2 - Make the line thickness of your Arrow shape animatable.
//
//  Created by William Spanfelner on 08/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.

import SwiftUI

struct ArrowShapeView: View {
    //Challenge 2 - Set the lineThickness from which the animation will begin
    @State private var lineThickness: CGFloat = 16
    @State private var showMessage = true
    
    var body: some View {
        VStack {
            ArrowShape()
                //Challenge 2 - the stroke, StrokeStyle desired and the dimensions of the frame required
                .stroke(Color.blue, style: StrokeStyle(lineWidth: lineThickness * 8, lineCap: .round, lineJoin: .bevel))
                .frame(width: 200, height: 300)
                //Challenge 2 - Select the animation trigger, the type and the final lineThickness
                .overlay(ArrowShape().foregroundColor(Color.yellow))
                .onTapGesture {
                    withAnimation(.spring(response: 1.5, dampingFraction: 0.6, blendDuration: 3)){
                        self.lineThickness = 2
                        self.showMessage = false
                    }
            }
            Text(showMessage ? "Tap Arrow" : "")
        }
    }
}

struct ArrowShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowShapeView()
    }
}
