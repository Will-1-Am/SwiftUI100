//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by William Spanfelner on 16/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //Using maxWidth and maxHeight is different from using width and height – we’re not saying the text view must take up all that space, only that it can. If you have other views around, SwiftUI will make sure they all get enough space.
            .background(Color.red)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
