//
//  UserDetailItem.swift
//  Friendface
//
//  Created by Erik Radicheski da Silva on 16/10/22.
//

import SwiftUI

struct UserDetailItem: View {
    let label: String
    let content: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(content)
                .multilineTextAlignment(.trailing)
        }
    }
}
