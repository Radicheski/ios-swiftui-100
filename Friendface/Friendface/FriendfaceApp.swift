//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import SwiftUI

@main
struct FriendfaceApp: App {
    @StateObject private var controller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, controller.container.viewContext)
                .onAppear {
                    Task {
                        await MainActor.run {
                            let controller = UserController(context: self.controller.container.viewContext)
                            controller.update()
                        }
                    }
                }
        }
    }
}
