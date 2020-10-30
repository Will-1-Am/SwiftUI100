//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by William Spanfelner on 19/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//
//[Core Data: Introduction](https://www.hackingwithswift.com/books/ios-swiftui/core-data-introduction)

import Foundation
import CoreData


extension Movie {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    //Adding computed properties can help us safely access the optional values
    public var wrappedTitle: String {
        return title ?? "Unknon title"
    }
    
}
