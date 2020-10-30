//
//  ContentView.swift
//  CoreDataProject
//
//  Created by William Spanfelner on 19/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import CoreData
/*
 MARK: @FetchRequest with predicate will filter base on a simple test. If nil is used for the predicate, then nothing will be filtered from the data entered in CoreData.
 
 NSPredicate(format: "universe == 'Star Wars'") will display the entries where the universe attribute is equal to "Star Wars"
 
 NSPredicate(format: "universe == %@", "Star Wars") is an equivalent predicate to that above, but can make it easier to read where lots of quotation marks are involved.
 
 NSPredicate(format: "name < %@", "F") will filter entries where the name attribute starts with letters occurring before the letter "F"
 
 NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"]) is used to check whether the universe attribute is contained within the array and displays the corresponding results.
 
 NSPredicate(format: "name BEGINSWITH %@", "E") will check whether the name attribute begins with the letter "E"
 
 NSPredicate(format: "name BEGINSWITH[c] %@", "e") will do the same as the previous, but it will ignore case.
 
 NSPredicate(format: "name CONTAINS[c] %@", "e") will just check whether a string contains a letter "e" regardless of case.
 
 NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e") will check for the inverse condition with the NOT operator - in this case it will show all the name attributes not beginning with the letter "e"
 
 If more complicated predicates are required, join them using AND to build up as much precision as you need, or import Core Data and use NSCompoundPredicate – it lets you build one large predicate modularly smaller predicates.
 
 */
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: nil) var ships: FetchedResults<Ship>
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    /*
     "As well as ==, we can also use comparisons such as < and > to filter our objects."
     */
    
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name > %@", "F")) var ships: FetchedResults<Ship>
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])) var ships: FetchedResults<Ship>
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH %@", "E")) var ships: FetchedResults<Ship>
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
//    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS[c] %@", "e")) var ships: FetchedResults<Ship>
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            DynamicFiltering()
            
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown ship")
            }
            //MARK: Multiple additions to a CoreData store can be done as follows.  Each tap of the "Add Examples" button will add the four following instances of Ship.
            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: self.moc)
                ship3.name = "Millenium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
