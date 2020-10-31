//
//  Users.swift
//  BucketList
//
//  Created by William Spanfelner on 30/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    //MARK: the following method uses the "<" operator to add functionality to it by, deciding whether a "user" is less than another.  This added functionality is called operator overloading. The method must return a boolean meaning the result must be either true or false. The method is marked static since it is applied directly to the struct and not just to instances of it. Now the .sorted() modifier in the View struct.
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
