//
//  FilteredList.swift
//  CoreDataProject Project 12 Challenge 1 - Make it accept an array of NSSortDescriptor objects to get used in its fetch request.

//
//  Created by William Spanfelner on 20/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    //MARK: Challenge 1 - create a property to build a sortDescriptor array - to keep it simple it will sort on lastname either ascending or descending
    var sortDescriptor: [NSSortDescriptor]

    //MARK: Challenge 1 - add a sortAscending parameter to the initializer
    init(sortAscending: Bool, filter: String) {
        sortDescriptor = [NSSortDescriptor(keyPath: \Singer.lastName, ascending: sortAscending)]
        
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: sortDescriptor, predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(sortAscending: true, filter:  "A")
    }
}
