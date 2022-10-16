//
//  AnyUser.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import Foundation

struct AnyUser: User {
    var id: UUID { user.id }
    var isActive: Bool { user.isActive }
    var name: String { user.name }
    var age: Int { user.age }
    var company: String { user.company }
    var email: String { user.email }
    var address: String { user.address }
    var about: String { user.about }
    var registered: Date { user.registered }
    var tags: [String] { user.tags }
    var friends: [AnyFriend] { user.friends.map(AnyFriend.init) }
    
    private let user: any User
    
    init(_ user: any User) {
        self.user = user
    }
}
