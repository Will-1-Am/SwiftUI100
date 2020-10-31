//
//  ActionSheetView.swift
//  Instafilter
//
//  Created by William Spanfelner on 24/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ActionSheetView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.clear
    
    var body: some View {
        Text("Hello, World!")
        .frame(width: 300, height: 300)
        .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Change Background"), message: Text("Select a new color"), buttons: [
            .default(Text("Red")) { self.backgroundColor = Color.red },
            .default(Text("Green")) { self.backgroundColor = Color.green },
            .default(Text("Blue")) { self.backgroundColor = Color.blue },
            .cancel()
            ])
        }
    }
}

struct ActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetView()
            .preferredColorScheme(.dark)
    }
}
