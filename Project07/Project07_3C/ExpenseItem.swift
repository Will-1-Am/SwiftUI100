//
//  ExpenseItem.swift
//  iExpense
//
//  Created by William Spanfelner on 30/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation

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
}
