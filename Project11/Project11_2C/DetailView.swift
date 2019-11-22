//
//  DetailView.swift
//  Bookworm
//
//  Created by William Spanfelner on 17/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        //the following modifiers were required for the images I added since they were considerably larger than the images provided and monopolised the space available.
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Text(self.book.genre?.uppercased() ?? "Fantasy")
                        .font(.caption)
                        .fontWeight(.black)
                    .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                    .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure you would like to delete this book?"), primaryButton: .destructive(Text("Delete")){
                self.deleteBook()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarTitle(Text(book.title ?? "Unknown book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
    
    func deleteBook() {
        moc.delete(book)
        
        //uncomment this line if the deletion is to be permanent
        //try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book. I really enjoyed it."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
