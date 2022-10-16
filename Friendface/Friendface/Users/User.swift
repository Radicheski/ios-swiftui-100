//
//  User.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import Foundation

protocol User: Identifiable {
    associatedtype F where F: Friend, F: Identifiable
    
    var id: UUID { get }
    var isActive: Bool { get }
    var name: String { get }
    var age: Int { get }
    var company: String { get }
    var email: String { get }
    var address: String { get }
    var about: String { get }
    var registered: Date { get }
    var tags: [String] { get }
    var friends: [F] { get }
}
