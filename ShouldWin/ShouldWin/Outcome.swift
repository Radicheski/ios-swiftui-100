//
//  Outcome.swift
//  ShouldWin
//
//  Created by Erik Radicheski da Silva on 02/10/22.
//

struct Outcome: Hashable {
    
    private static var possibilities: [Outcome: Action] = [
        Outcome(app: .paper, user: .paper): .draw,
        Outcome(app: .scissors, user: .scissors): .draw,
        Outcome(app: .rock, user: .rock): .draw,
        
        Outcome(app: .paper, user: .rock): .lose,
        Outcome(app: .scissors, user: .paper):.lose,
        Outcome(app: .rock, user: .scissors): .lose,
        
        Outcome(app: .paper, user: .scissors): .win,
        Outcome(app: .scissors, user: .rock): .win,
        Outcome(app: .rock, user: .paper): .win
    ]
    
    let app: Choice
    let user: Choice
    
    var outcome: Action {
        Self.possibilities[self]!
    }
    
    func getCorrectAnswer(to action: Action, for choice: Choice) -> Choice {
        return Self.possibilities.first(where: { $0.value == action && $0.key.app == choice })!.key.user
    }
    
}

