//
//  CreatingACustomComponentWith@Binding.swift
//  Bookworm
//
//  Created by William Spanfelner on 15/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

/*
 This object is created with a @Binding property to track and synchronise its state with the
 View from which it is displayed to the user
 */
struct PushButton: View {
    let title: String
    @Binding var isOn: Bool //@State
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    /*
     MARK: isOn is toggled when the button is tapped and the state of rememberMe in the PushButtonView is updated.
     */
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(Color.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

//struct PushButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PushButton(title: "Tap Me", isOn: $rememberMe)
//    }
//}
