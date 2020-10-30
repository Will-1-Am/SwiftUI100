//
//  FilterListView.swift
//  CoreDataProject
//
//  Created by William Spanfelner on 21/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

enum Predicate: String {
    case beginsWith
    case beginsWithAnyCase
    case contains
    case containsAnyCase
}

struct FilterListView: View {
    @Environment(\.managedObjectContext) var moc
    @State var lastNameFilter = "A"
    @State var sortAscending = true
    @State var filterMethod = Predicate.containsAnyCase//"BEGINSWITH[c]"//"CONTAINS"//"BEGINSWITH"
    
    var count = 2 {
        didSet {
            count += 1
            print(count)
        }
    }
    
    var body: some View {
        VStack {
//            FilteredList(method: filterMethod, filter: lastNameFilter)
            FilteredList(method: filterMethod, sortAscending: sortAscending, filter: lastNameFilter)
            
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
                
                let cat = Singer(context: self.moc)
                cat.firstName = "Cat"
                cat.lastName = "Stevens"
                
                let bruce = Singer(context: self.moc)
                bruce.firstName = "Bruce"
                bruce.lastName = "Springstein"
                
                let rod = Singer(context: self.moc)
                rod.firstName = "Rod"
                rod.lastName = "Stewart"
                
                let al = Singer(context: self.moc)
                al.firstName = "Al"
                al.lastName = "Stewart"
                
                let dave = Singer(context: self.moc)
                dave.firstName = "Dave"
                dave.lastName = "Stewart"
                
                try? self.moc.save()
            }
            
            HStack {
                Spacer()
                
                Button("Show A") {
                    self.lastNameFilter = "A"
                }
                
                Spacer()
                
                Button("Show S") {
                    self.lastNameFilter = "S"
                }
                
                Spacer()
                
                Button("Sort Toggle") {
                    self.sortAscending.toggle()
                }
                
                Spacer()
            }
                Button("Filter") {
                    self.filterMethod = Predicate(rawValue: Predicate.RawValue(self.count)) ?? Predicate.beginsWith
                }
            
        }
    }
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView()
    }
}
