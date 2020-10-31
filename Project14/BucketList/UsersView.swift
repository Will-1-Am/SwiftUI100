//
//  UsersView.swift
//  BucketList
//
//  Created by William Spanfelner on 30/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct UsersView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
        //MARK: The users array can be sorted using the standard modifier, but a more efficient way would be to use the COMPARABLE protocol starting with the User struct.
//        .sorted { $0.lastName < $1.lastName }

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
