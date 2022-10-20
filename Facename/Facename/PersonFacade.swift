//
//  PersonFacade.swift
//  Facename
//
//  Created by Erik Radicheski da Silva on 20/10/22.
//

import SwiftUI

struct PersonFacade: View {
    private var person: Person
    
    var image: Image {
        if let uiImage = person.image {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.fill")
        }
    }
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 80)
            Text(person.name)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
        }
    }
    
    init(_ person: Person) {
        self.person = person
    }
}

struct PersonFacade_Previews: PreviewProvider {
    static var previews: some View {
        PersonFacade(Person(name: "Name"))
    }
}
