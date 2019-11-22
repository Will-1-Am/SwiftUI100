//
//  AddBookView.swift
//  Bookworm
//
//  Created by William Spanfelner on 16/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    /*
     MARK: .managedObjectContext here is used as location in which to store the properties that are created[Creating books with Core Data](https://www.hackingwithswift.com/books/ios-swiftui/creating-books-with-core-data)
     */
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    //MARK: Challenge 3 - create a property and a CoreData attribute for the date of type String - if you it is created as a Date type in CoreData it must be deleted entirely and recreated as a String - otherwise crashy crashy…
    var date: String {
        //MARK: Challenge 3 - Enter the date automatically as todays date and the current time.
        let date = Date()
        
        //MARK: Challenge 3 - Format and return the date as desired
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        
        let friendlyDate = formatter.string(from: date)
        return friendlyDate
    }
    
    let genres = [ "Fantasy", "Fiction", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Space Travel", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        //add the book
                        let newBook = Book(context: self.moc)
                        //MARK: Challenge 3 - add the date to the list of attributes to be updated
                        newBook.date = self.date
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        
                        try? self.moc.save()
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationBarTitle("Add Book")
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
