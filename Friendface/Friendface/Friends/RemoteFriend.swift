//
//  RemoteFriend.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import Foundation

struct RemoteFriend: Friend, Codable {
    let id: UUID
    let name: String
}
