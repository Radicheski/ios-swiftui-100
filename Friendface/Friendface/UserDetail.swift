//
//  UserDetail.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import SwiftUI

struct UserDetail: View {
    let user: User
    
    var body: some View {
        Form {
            Section {
                UserDetailItem(label: "Age", content: "\(user.age) years old")
                UserDetailItem(label: "Company", content: user.company)
                UserDetailItem(label: "E-mail", content: user.email)
                UserDetailItem(label: "Address", content: user.address)
            }
            
            Section("About") {
                Text(user.about)
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name)
    }
}
