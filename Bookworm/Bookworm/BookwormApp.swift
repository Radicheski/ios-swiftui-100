//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Erik Radicheski da Silva on 14/10/22.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
