//
//  FilteredList.swift
//  CoreDataProject Project 12 Challenge 2 - Make it accept a string parameter that controls which predicate is applied. You can use Swift’s string interpolation to place this in the predicate.

//
//  Created by William Spanfelner on 20/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    var sortDescriptor: [NSSortDescriptor]
    
    //MARK: Challenge 2 - Added filter method predicate to initializer and used string interpolation for inserting the filter method in the predicate
    init(method: String, filter: String) {
        sortDescriptor = [NSSortDescriptor(keyPath: \Singer.lastName, ascending: sortAscending)]
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(),
                                            sortDescriptors: sortDescriptor,
                                            predicate:
                                                NSPredicate(format: "lastName \(method) %@", filter)
        ) //BEGINSWITH
    }
    
    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
    
    var body: some View {
        List(singers, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(method: "lastName", filter:  "A")
    }
}
