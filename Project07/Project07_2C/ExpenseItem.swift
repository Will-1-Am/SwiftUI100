//
//  ExpenseItem.swift
//  iExpense
//
//  Created by William Spanfelner on 30/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

/*
 Identifiable is one of the protocols built into Swift, and means
 “this type can be identified uniquely.” It has only one requirement,
 which is that there must be a property called id that contains
 a unique identifier.
 */
struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
    //Challenge 2 - create a new property for the expense color category code
    let amountCategory: Int
}
