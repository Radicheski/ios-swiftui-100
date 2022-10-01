//
//  GameArea.swift
//  ShouldWin
//
//  Created by Erik Radicheski da Silva on 02/10/22.
//

import SwiftUI

struct GameArea: View {
    
    var choice: Choice
    var action: Action
    var round: Int
    var score: Int
    var closure: (Choice) -> Void
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("\(round)/10")
                    Spacer()
                        .frame(width: 100)
                    Text("Score: \(score)")
                }
                Spacer()
                    .frame(height: 50)
                Group {
                    Text("I choose ") + Text(choice.rawValue).underline() + Text(".")
                }
                .font(.title2)
                Spacer()
                    .frame(height: 30)
                Group {
                    Text("To ") + Text(action.rawValue).underline() + Text(" you should choose:")
                }
                .font(.title2)
                Spacer()
                    .frame(height: 50)
                ForEach(Choice.allCases.shuffled(), id: \.self) { choice in
                    ChoiceButton(choice: choice) { closure($0) }
                }
            }
            .frame(width: 350, height: 400)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
}

struct GameArea_Previews: PreviewProvider {
    static var previews: some View {
        GameArea(choice: .scissors, action: .lose, round: Int.random(in: 1 ... 10), score: Int.random(in: -10 ... 10)) { _ in }
    }
}
