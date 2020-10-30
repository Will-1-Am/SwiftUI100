//
//  FilteredList.swift
//  CoreDataProject Project 12 Challenge 3 -  Modify the predicate string parameter to be an enum such as .beginsWith, then make that enum get resolved to a string inside the initializer.
//
//  Created by William Spanfelner on 20/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    var sortDescriptor: [NSSortDescriptor]
    
//    init(method: Predicate, filter: String) {
    init(method: Predicate, sortAscending: Bool, filter: String) {
        sortDescriptor = [NSSortDescriptor(keyPath: \Singer.lastName, ascending: sortAscending)]
        
        var predicatMethod = ""
        
        switch method {
        case .beginsWith:
            predicatMethod = "BEGINSWITH"
        case .beginsWithAnyCase:
            predicatMethod = "BEGINSWITH[c]"
        case .contains:
            predicatMethod = "CONTAINS"
        case .containsAnyCase:
            predicatMethod = "CONTAINS[c]"
        }

        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: sortDescriptor, predicate: NSPredicate(format: "lastName \(predicatMethod) %@", filter))
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
//        FilteredList(method: Predicate.contains, filter:  "A")
        FilteredList(method: Predicate.contains, sortAscending: true, filter:  "A")
    }
}
