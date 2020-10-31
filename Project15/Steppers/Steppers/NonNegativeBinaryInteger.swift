//
//  NonNegativeBinaryInteger.swift
//  Steppers
//
//  Created by William Spanfelner on 09/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation

@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value
    
    init(wrappedValue: Value) {
        if wrappedValue < 0 {
            self.value = 0
        } else {
            self.value = wrappedValue
        }
    }
    
    var wrappedValue: Value {
        get { value }
        
        set {
            if newValue < 0 {
                value = 0
            } else {
                value = newValue
            }
        }
    }
}

struct User {
    @NonNegative var score = 0
}


