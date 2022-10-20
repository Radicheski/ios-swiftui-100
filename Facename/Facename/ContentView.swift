//
//  ContentView.swift
//  Facename
//
//  Created by Erik Radicheski da Silva on 20/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var controller = PersonController()
    
    @State private var showingEditView = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(controller.people) {person in
                        NavigationLink {
                            PersonDetail(controller: controller, person: person)
                        } label: {
                            PersonFacade(person)
                        }
                    }
                    .onDelete(perform: controller.delete(at:))
                }
                
                Section {
                    HStack {
                        Text("Add new person")
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                    }
                    .onTapGesture(perform: addPerson)
                }
            }
            .navigationTitle("Facename")
        }
        .sheet(isPresented: $showingEditView) {
            PersonEdit(controller: controller)
        }
    }
    
    private func addPerson() {
        showingEditView = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
