//
//  PersonController.swift
//  Facename
//
//  Created by Erik Radicheski da Silva on 20/10/22.
//

import Foundation

class PersonController: ObservableObject {
    private let filename = "people.json"
    
    @Published private(set) var people = [Person]() {
        didSet {
            do {
                let data = try JSONEncoder().encode(people)
                let url = FileManager.default.documentDirectory.appending(component: filename)
                try data.write(to: url, options: .atomic)
            } catch {
                print("There was an error when trying to save data. \(error.localizedDescription)")
            }
        }
    }
    
    func save(person: Person) {
        people.append(person)
        people.sort()
    }
    
    func delete(at offsets: IndexSet) {
        let indexes = Array(offsets)
        
        let images = indexes.map { "\(people[$0].id).jpg" }
        let documentDirectory = FileManager.default.documentDirectory
        
        for image in images {
            let url = documentDirectory.appending(component: image)
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print("Failed to delete image \(image). \(error.localizedDescription)")
            }
        }
        
        people.remove(atOffsets: offsets)
    }
    
    init() {
        let url = FileManager.default.documentDirectory.appending(component: filename)
        do {
            let data = try Data(contentsOf: url)
            let people = try JSONDecoder().decode([Person].self, from: data)
            self.people = people
        } catch {
            print("There was an error when trying to load data. \(error.localizedDescription)")
            self.people = []
        }
    }
    
}
