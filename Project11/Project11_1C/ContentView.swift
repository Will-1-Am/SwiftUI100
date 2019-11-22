//
//  ContentView.swift
//  Bookworm - Project11 - Challenge 1 - Right now it’s possible to select no genre for books, which causes a problem for the detail view. Please fix this, either by forcing a default, validating the form, or showing a default picture for unknown genres – you can choose.
//
//  Created by William Spanfelner on 15/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                     NavigationLink(destination: DetailView(book: book)) {
//                    NavigationLink(destination: Text(book.title ?? "Unknown Title")) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }.onDelete(perform: deleteBooks)
            }
//            Text("Count: \(books.count)")
                .navigationBarTitle("Bookworm")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                        .padding(20)
                        //            .background(Color.blue)
                        .clipShape(Circle())
                })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            //find this book in the fetchRequest
            let book = books[offset]
            
            //delete it from the context
            moc.delete(book)
        }
        //save the context
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
