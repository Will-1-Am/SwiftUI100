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
    //MARK: Challenge 1 - a state property is created to hold the boolean value of sortAscending
    @State var sortAscending = true
    
    var body: some View {
        VStack {
            FilteredList(sortAscending: sortAscending, filter: lastNameFilter)

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
                
                //MARK: Challenge 1 - more "S" musician example data added for sake of interest
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
             //MARK: Challenge 1 - Added a toggle for flipping the state value
                Button("Sort Toggle") {
                    self.sortAscending.toggle()
                }
                
                Spacer()
            }
        }
    }
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView()
    }
}
