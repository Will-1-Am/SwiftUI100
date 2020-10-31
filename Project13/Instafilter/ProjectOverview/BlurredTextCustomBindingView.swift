//
//  BlurredTextView.swift
//  Instafilter
//
//  Created by William Spanfelner on 24/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct BlurredTextCustomBindingView: View {
    
    //MARK: The code should print a message stating the new blurAmount, but because @State properties have a non-mutating set, the change to the property is never detected in the conventional property observer way.
    @State private var blurAmount: CGFloat = 3.75 //{
    //        didSet {
    //            print("The new value is \(blurAmount)")
    //        }
    //    }
    //MARK: The body needs to be modifyied to be able to print, execute a closure, or add other additional functionality.
    
    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("The new value is \(self.blurAmount)")
            }
        )
        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            Slider(value: blur, in: 0...7.5)
        }.padding()
    }
    /*
     As can be found from cmd + shift + o, the Binding has an initializer as follows:
     
         init(get: @escaping () -> Value, set: @escaping (Value) -> Void)
     
     The get and set are escaping closures that store their values for later use, the get takes a closure with no parameters and returns a value, and the set takes a closure with a single value parameter and returns void.
     */
}

struct BlurredTextView_Previews: PreviewProvider {
    static var previews: some View {
        BlurredTextCustomBindingView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
