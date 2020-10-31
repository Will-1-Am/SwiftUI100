//
//  Result.swift
//  BucketList
//
//  Created by William Spanfelner on 03/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation

//MARK: The purpose of this file is to store the JSON data that will be received from Wikipedia

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    //MARK: Conforming to Comparable requires that a < function that accepts two parameters of the type of the Struct and return true if the first parameter must be sorted before the second
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information available"
    }
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
        //MARK: This function will permit sorting with the .sorted() method without any additional parameters
    }
}
