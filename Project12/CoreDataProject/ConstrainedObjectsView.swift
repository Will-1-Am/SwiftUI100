//
//  ConstrainedObjectsView.swift
//  CoreDataProject
//
//  Created by William Spanfelner on 20/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ConstrainedObjectsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            //: From the lession: [Ensuring Core Data objects are unique using constraints](https://www.hackingwithswift.com/books/ios-swiftui/ensuring-core-data-objects-are-unique-using-constraints)
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknow")
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ConstrainedObjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ConstrainedObjectsView()
    }
}
