//
//  ContentView.swift
//  Bookworm - Project11 - Challenge 2 - Modify ContentView so that books rated as 1 star have their name shown in red.
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
                                //MARK: Challenge 2 - ternary operator for text color
                                .foregroundColor(book.rating < 2 ? Color.red : .primary )
                            
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
