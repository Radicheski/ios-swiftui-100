//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Erik Radicheski da Silva on 30/09/22.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    var description: String?
    var onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Image(name)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
                .accessibilityLabel(description ?? "Unknown flag")
        }
    }
}
