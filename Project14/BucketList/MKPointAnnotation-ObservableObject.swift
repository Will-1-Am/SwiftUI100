//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by William Spanfelner on 03/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unkown value"
        }
        set {
            subtitle = newValue
        }
    }
}
