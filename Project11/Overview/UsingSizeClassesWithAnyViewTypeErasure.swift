//
//  Using size classes withAnyViewTypeErasure.swift
//  Bookworm
//
//  Created by William Spanfelner on 15/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct SizeClassView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    // Running the following code in the iPad 12.9" simulator it will display when the size class changes
//    var body: some View {
//        if sizeClass == .compact {
//            return HStack {
//                Text("Active size class:")
//                Text("COMPACT")
//            }
//            .font(.largeTitle)
//        } else {
//            return HStack {
//                Text("Active size class:")
//                Text("REGULAR")
//            }
//            .font(.largeTitle)
//        }
//    }
    
    /*
     If it were decided that it is desirable to return different types depending on the size class detected, it might be tempting to change a VStack for an HStack.  However, the following will not compile since it is trying to return differnt types ie a VStack & an HStack.  This will compile if wrapped in a Group and the return keywords removed - that also produces the desired effect.
     */
//    var body: some View {
////        Group {
//            if sizeClass == .compact {
//                 return VStack {
//                    Text("Active size class:")
//                    Text("COMPACT")
//                }
//                .font(.largeTitle)
//            } else {
//                return HStack {
//                    Text("Active size class:")
//                    Text("REGULAR")
//                }
//                .font(.largeTitle)
//            }
////        }
//    }
    
    // A type erased wrapper allows the code to compile using the AnyView type to conform to the View protocol common to VStack, Text, Color, etc.  Externally, AnyView does not reveal what it contains and ostensibly hides the view contained within. These benefits come at the cost of performance, so it should be used sparingly.
    var body: some View {
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}

struct SizeClassView_Previews: PreviewProvider {

    static var previews: some View {
        SizeClassView()
    }
}
