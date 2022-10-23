//
//  Prospect.swift
//  HotProspects
//
//  Created by Erik Radicheski da Silva on 22/10/22.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    private let userDefaultsKey = "SavedData"
    
    @Published private(set) var people: [Prospect] {
        didSet {
            save()
        }
    }
    
    init() {
        let url = Self.documentDirectory.appending(component: userDefaultsKey)
        if let data = try? Data(contentsOf: url) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
            
        people = []
    }
    
    private func save() {
        let url = Self.documentDirectory.appending(component: userDefaultsKey)
        if let encoded = try? JSONEncoder().encode(people) {
            try? encoded.write(to: url)
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
    }
    
    static var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
