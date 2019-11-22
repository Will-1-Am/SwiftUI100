//
//  ContentView.swift
//  Bookworm
//
//  Created by William Spanfelner on 15/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    /*
     MARK: @FetchRequest is a property wrapper for retrieving data from CoreData and takes two parameters - the CoreData entity and the way it should be sorted. The data is stored in the students property as a FetchedResult<Student> type. The plot thickens…  The Student entity is created via CoreData inheriting from a NSManagedObject class. Swift add this to the Environment as a managed object context which is in turn responsible for fetching and retrieving data so, access to the managed object context is required via the moc property.
     */
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!
                
                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
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
