//
//  Friend.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import Foundation

protocol Friend: Identifiable {
    var id: UUID { get }
    var name: String { get }
}
