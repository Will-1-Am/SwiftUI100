//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by William Spanfelner on 16/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16
    
    var body: some View {
        switch rating {
        case 1:
            return Text("1")
        case 2:
            return Text("2")
        case 3:
            return Text("3")
        case 4:
            return Text("4")
        default:
            return Text("5")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
