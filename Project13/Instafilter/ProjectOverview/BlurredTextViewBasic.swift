//
//  BlurredTextViewBasic.swift
//  Instafilter
//
//  Created by William Spanfelner on 24/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct BlurredTextViewBasic: View {

    @State private var blurAmount: CGFloat = 3.75

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            Slider(value: $blurAmount, in: 0...7.5)
        }.padding()
    }
}

struct BlurredTextViewBasic_Previews: PreviewProvider {
    static var previews: some View {
        BlurredTextViewBasic()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
