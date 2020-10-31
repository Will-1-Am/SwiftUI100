//
//  MKPointAnnotation-Codable.swift
//  BucketList
//
//  Created by William Spanfelner on 04/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation
import MapKit

//MARK: Store the MKPointAnnotations that the user has entered

/*
 MARK: The extension presents a major issue with the compiler reporting:

 "required' initializer must be declared directly in class 'MKPointAnnotation' (not in an extension)"
 
 This is happening since MKPointAnnotation is not a final class meaning that subclasses can inherit from it.  So to work around this, there are three options.
 1. Create a custom class that conforms to the MKAnnotation like MKPointAnnotation;
 2. Create a subclass of MKPointAnnotation conformant to Codable.  The subclass would be invisible to the parent and therefore the parent would be oblivious to the Codable conformance;
 3. Create a wrapper struct conforming to Codable and nest an MKPointAnnotation instance
 */

//extension MKPointAnnotation: Codable {
//    public required init(from decoder: Decoder) throws {
//
//    }
//
//    public func encode(to encoder: Encoder) throws {
//
//    }
//}

class CodableMKPointAnnotation: MKPointAnnotation, Codable {
    enum CodingKeys: CodingKey {
        case title, subtitle, latitude, longitude
    }
    
    override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
}
