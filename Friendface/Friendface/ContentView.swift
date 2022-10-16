//
//  ContentView.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    UserDetail(user: user)
                } label: {
                    UserView(user: user)
                }
            }
            .navigationTitle("Friendface")
        }
        .onAppear {
            Task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard users.isEmpty else { return }
        
        if let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json"),
            let users: [User] = try? await Network.getData(from: url) {
            self.users = users
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
