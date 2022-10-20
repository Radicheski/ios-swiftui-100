//
//  PersonDetail.swift
//  Facename
//
//  Created by Erik Radicheski da Silva on 20/10/22.
//

import SwiftUI

struct PersonDetail: View {
    @ObservedObject private var controller: PersonController
    private var person: Person
    
    @State private var showEditView = false
    
    var image: Image {
        if let uiImage = person.image {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.fill")
        }
    }
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .background(.secondary)
            .frame(maxWidth: .infinity)
            .padding()
            .navigationTitle(person.name)
            .toolbar {
                Button {
                    showEditView = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
            .sheet(isPresented: $showEditView) {
                PersonEdit(controller: controller)
            }
            
    }
    
    init(controller: PersonController, person: Person) {
        self.controller = controller
        self.person = person
    }
}

struct PersonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetail(controller: PersonController(), person: Person(name: "Name"))
    }
}
