//
//  CachedUser.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import CoreData
import Foundation

extension CachedUser: User {
    public var id: UUID { self.zId ?? UUID() }
    var isActive: Bool { self.zIsActive }
    var name: String { self.zName ?? "Unknown Name" }
    var age: Int { Int(self.zAge) }
    var company: String { self.zCompany ?? "" }
    var email: String { self.zEmail ?? "" }
    var address: String { self.zAddress ?? "" }
    var about: String { self.zAbout ?? "" }
    var registered: Date { self.zRegistered ?? .distantPast }
    var tags: [String] { self.zTags?.components(separatedBy: ",") ?? [] }
    var friends: [AnyFriend] {
        if let set = self.zFriends as? Set<CachedFriend> {
            return set.map(AnyFriend.init)
        } else {
            return []
        }
    }
    
    convenience init(context: NSManagedObjectContext, user: any User) {
        self.init(context: context)
        
        self.zId = user.id
        self.zIsActive = user.isActive
        self.zName = user.name
        self.zAge = Int16(user.age)
        self.zCompany = user.company
        self.zEmail = user.email
        self.zAddress = user.address
        self.zAbout = user.about
        self.zRegistered = user.registered
        self.zTags = user.tags.joined(separator: ",")
        
        if let context = self.managedObjectContext {
            user.friends.map { CachedFriend(context: context, friend: $0, user: self) }
                .forEach(self.addToZFriends)
        }
    }
}
