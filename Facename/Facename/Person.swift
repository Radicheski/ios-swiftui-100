//
//  Person.swift
//  Facename
//
//  Created by Erik Radicheski da Silva on 20/10/22.
//

import Foundation
import SwiftUI

struct Person: Codable, Identifiable {
    let id: UUID
    var name: String
    
    var image: UIImage? {
        didSet {
            let url = FileManager.default.documentDirectory.appending(component: "\(id).jpg")
            if let data = image?.jpegData(compressionQuality: 0.8),
               let _ = try? data.write(to: url) {
                print("Image saved succesfully.")
            } else {
                print("Error when saving image.")
            }
        }
    }
    
    init(name: String) {
        id = UUID()
        self.name = name
    }
    
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        let url = FileManager.default.documentDirectory.appending(component: "\(id).jpg")
        if let data = try? Data(contentsOf: url) {
            image = UIImage(data: data)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
