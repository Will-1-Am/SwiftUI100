//
//  SortedArrayView.swift
//  BucketList
//
//  Created by William Spanfelner on 30/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct SortedArrayView: View {
    let values = [1, 5, 3, 7, 2, 9].sorted()
    
    var body: some View {
        List(values, id: \.self) {
            Text(String($0))
        }
    }
}

struct SortedArrayView_Previews: PreviewProvider {
    static var previews: some View {
        SortedArrayView()
    }
}
