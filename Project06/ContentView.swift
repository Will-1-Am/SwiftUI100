//
//  ContentView.swift
//  Animations
//
//  Created by William Spanfelner on 25/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
// [Animating gestures](https://www.hackingwithswift.com/books/ios-swiftui/animating-gestures)
/*
 The following animation allows you to drag a string of characters around the screen and snap back to the origin in a snake like fashion
 */
import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
