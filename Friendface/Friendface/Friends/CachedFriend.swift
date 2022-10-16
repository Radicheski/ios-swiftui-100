//
//  CachedFriend.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import CoreData
import Foundation

extension CachedFriend: Friend {
    public var id: UUID { self.zId ?? UUID() }
    var name: String { self.zName ?? "Unknown Name" }
    
    convenience init(context: NSManagedObjectContext, friend: any Friend, user: CachedUser) {
        self.init(context: context)
        
        self.zId = friend.id
        self.zName = friend.name
        
        self.addToZUser(user)
    }
}
