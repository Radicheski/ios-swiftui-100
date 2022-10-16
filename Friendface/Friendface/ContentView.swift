//
//  ContentView.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) private var zUsers: FetchedResults<CachedUser>
    var users: [AnyUser] {
        zUsers.map(AnyUser.init)
    }
    
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
