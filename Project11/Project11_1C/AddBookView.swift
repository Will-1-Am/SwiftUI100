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
    
    //MARK: Challenge 1 - add a property observer to monitor whether a genre has been selected
    var genreNotSelected: Bool {
        return genre.isEmpty ? true : false
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
                    }//.pickerStyle(SegmentedPickerStyle())
                    // FIXME: Why does the picker list jump when displayed
                    // FIXME: How to make a segmented picker span more lines?
                }
                
                Section {
                    RatingView(rating: $rating)

                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        //add the book
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        
                        try? self.moc.save()
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    //MARK: Challenge 1 - disabled modifier added to Section to disable save button until genre is selected
                }.disabled(genreNotSelected)
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
