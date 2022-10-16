//
//  Network.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import Foundation

enum Network {
    static func getData<T: Codable>(from url: URL) async throws -> T {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}
