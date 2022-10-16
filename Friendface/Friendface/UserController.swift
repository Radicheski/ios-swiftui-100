//
//  UserController.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import CoreData
import Foundation

struct UserController {
    let context: NSManagedObjectContext
    
    func update() {
        if let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") {
            Network.getData(from: url) { (array: [RemoteUser]) in
                
                array.forEach { let _ = CachedUser(context: self.context, user: $0) }
                if self.context.hasChanges {
                    do {
                        try self.context.save()
                    } catch {
                        print("Core Data failed to save: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
