//
//  GenericFilteredList.swift
//  CoreDataProject
//
//  Created by William Spanfelner on 20/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import CoreData

struct GenericFilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    //this is the content closure: it is called once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}

//struct GenericFilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        GenericFilteredList<Any, >(filterKey: "A", filterValue: "", content: )
//    }
//}
