//
//  ChoiceButton.swift
//  ShouldWin
//
//  Created by Erik Radicheski da Silva on 02/10/22.
//

import SwiftUI

struct ChoiceButton: View {
    
    var choice: Choice
    var action: (Choice) -> Void
    
    var body: some View {
        Button {
            action(choice)
        } label: {
            Text(choice.rawValue)
                .frame(width: 200, height: 25)
                .backgroundStyle(.ultraThinMaterial)
                .foregroundColor(.indigo)
        }
        .buttonStyle(.bordered)
        .backgroundStyle(.clear)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(radius: 5)
    }
    
}
