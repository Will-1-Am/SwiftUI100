//
//  PushButtonView.swift
//  Bookworm
//
//  Created by William Spanfelner on 15/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct PushButtonView: View {
    @State private var rememberMe = false
    
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct PushButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PushButtonView()
    }
}
