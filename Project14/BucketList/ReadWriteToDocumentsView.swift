//
//  ReadWriteToDocumentsView.swift
//  BucketList
//
//  Created by William Spanfelner on 30/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ReadWriteToDocumentsView: View {
    var body: some View {
        
        Text("\(getDocumentsDirectory())")
            .onTapGesture {
                let str = "Test Message"
                let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                    
                } catch {
                    print(error.localizedDescription)
                }
        }
    }
}

struct ReadWriteToDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        ReadWriteToDocumentsView()
    }
}
