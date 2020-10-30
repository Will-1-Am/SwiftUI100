//
//  Country+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by William Spanfelner on 20/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?
    
    public var wrappedFullName: String {
        fullName ?? "Unknown Country"
    }
    
    public var wrappedShortName: String {
        shortName ?? "Unknown Country"
    }
    
    /*
     MARK: NSSet is an Objective C data type and is not compatible with SwiftUI's ForEach.
     Converting the NSSet to Set<Candy> needs to happen for it to be useful.
     Then the set can be converted to an array and finally sorted.
     */
    public var candyArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        /*
         set is an unordered "array" of unique elements and should candy be nil an empty array will be assigned to set.
         When a set is sorted an array is returned automatically, but Swift needs to know how to sort the elements since the set is composed of custom types
         */
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}
