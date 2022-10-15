//
//  AddBookView.swift
//  Bookworm
//
//  Created by Erik Radicheski da Silva on 14/10/22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mistery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: context)
                        
                        title = title.trimmingCharacters(in: .whitespaces)
                        author = author.trimmingCharacters(in: .whitespaces)
                        genre = genre.trimmingCharacters(in: .whitespaces)
                        review = review.trimmingCharacters(in: .whitespaces)
                        
                        newBook.id = UUID()
                        newBook.title = title.isEmpty ? "Unknown Book" : title
                        newBook.author = author.isEmpty ? "Unknown Author" : author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre.isEmpty ? "Fantasy" : genre
                        newBook.review = review
                        newBook.date = .now
                        
                        try? context.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
