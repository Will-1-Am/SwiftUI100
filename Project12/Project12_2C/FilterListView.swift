//
//  FilterListView.swift
//  CoreDataProject
//
//  Created by William Spanfelner on 21/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct FilterListView: View {
    @Environment(\.managedObjectContext) var moc
    @State var lastNameFilter = "A"
    //MARK: Challenge 2 - state property created for the filter method to apply
    @State var filterMethod = "BEGINSWITH[c]"//"CONTAINS"//"BEGINSWITH"
    
    var body: some View {
        VStack {
            FilteredList(method: filterMethod, filter: lastNameFilter)

            Button("Add Example") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView()
    }
}
