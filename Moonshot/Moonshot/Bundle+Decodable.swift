//
//  Bundle+Decodable.swift
//  Moonshot
//
//  Created by Erik Radicheski da Silva on 07/10/22.
//

import Foundation

extension Bundle {
    
    func decode<T>(_ file: String) -> T where T: Decodable {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to deecode \(file) from bundle.")
        }
        
        return loaded
    }
    
}
