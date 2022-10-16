//
//  AnyFriend.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import Foundation

struct AnyFriend: Friend {
    var id: UUID { friend.id }
    var name: String { friend.name }
    
    private let friend: any Friend
    
    init(_ friend: any Friend) {
        self.friend = friend
    }
}
