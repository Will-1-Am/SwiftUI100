//
//  TextViews.swift
//  Accessibility
//
//  Created by William Spanfelner on 07/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct TextViews: View {
    var body: some View {
        VStack {
            VStack {
                Text("Your score is:")
                Text("1000")
                    .font(.title)
            }
                
                //MARK: Accessibility will determine the above two Text views as separate and unrelated and will activate VoiceOver separately for each field selection.  If the followin modifier is applied the fields are treated as a single unit.  .combine inserts a pause in the reading of the two pieces of the text.
                .accessibilityElement(children: .combine)
            
            VStack {
                Text("Your score is:")
                Text("1000")
                    .font(.title)
            }
                //MARK: Ignoring the children and providing separate label text maybe a superior approach depending on needs. .ignore disregards the natural breaks between any physically separate text fields.
                .accessibilityElement(children: .ignore)
                .accessibility(label: Text("Your score is: 1000"))
        }
    }
}

struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        TextViews()
    }
}
