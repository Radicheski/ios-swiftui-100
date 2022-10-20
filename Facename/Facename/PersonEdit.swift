//
//  PersonEdit.swift
//  Facename
//
//  Created by Erik Radicheski da Silva on 20/10/22.
//

import SwiftUI

struct PersonEdit: View {
    @ObservedObject private var controller: PersonController
    
    @State private var person: Person
    @State private var uiImage: UIImage?
    var image: Image {
        if let uiImage = person.image {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.fill")
        }
    }
    
    @State private var showImagePicker = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $person.name)
                }
                
                Section {
                    HStack {
                        Spacer()
                        image
                            .resizable()
                            .scaledToFit()
                            .background(.secondary)
                            .frame(idealWidth: .infinity, maxWidth: .infinity)
                            .onTapGesture {
                                showImagePicker = true
                            }
                        Spacer()
                    }
                }
            }
            .toolbar {
                Button("Save") {
                    controller.save(person: person)
                    dismiss()
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $uiImage)
            }
            .onChange(of: uiImage) { newValue in
                person.image = newValue
            }
        }
    }
    
    init(controller: PersonController, person: Person = Person(name: "New person")) {
        self.controller = controller
        self._person = State(initialValue: person)
    }
    
}

struct PersonEdit_Previews: PreviewProvider {
    static var previews: some View {
        PersonEdit(controller: PersonController())
    }
}
