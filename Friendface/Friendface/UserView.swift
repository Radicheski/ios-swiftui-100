//
//  UserView.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        HStack {
            Text(user.name)
            Spacer()
            Text(user.isActive ? "active" : "inactive")
                .foregroundColor(user.isActive ? .green.opacity(0.7) : .red.opacity(0.7))
                .font(.caption)
        }
    }
}
