//
//  Network.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import Foundation

enum Network {
    static func getData<T: Codable>(from url: URL, completionHandler: @escaping (T) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let data: Data
            do {
                data = try Data(contentsOf: url)
            } catch {
                print("Failed to load data from server: \(error.localizedDescription)")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completionHandler(decodedData)
            } catch {
                print("Failed to decode data: \(error.localizedDescription)")
            }
        }
    }
}
