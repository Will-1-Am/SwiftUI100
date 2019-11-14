//
//  Spirograph.swift
//  Drawing
//
//  Created by William Spanfelner on 07/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: CGFloat

    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor) * amount)
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0{
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        return a
    }
}


struct Spirograph_Previews: PreviewProvider {
    static var previews: some View {
        Spirograph(innerRadius: 2, outerRadius: 5, distance: 2, amount: 5)
    }
}
