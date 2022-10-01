//
//  ContentView.swift
//  ShouldWin
//
//  Created by Erik Radicheski da Silva on 01/10/22.
//

import SwiftUI

struct ContentView: View {
    
    var choices = Choice.allCases
    @State var appChoice = Int.random(in: 0 ..< Choice.allCases.count)
    
    var actions = Action.allCases
    @State var expectedAction = Int.random(in: 0 ..< Choice.allCases.count)
    
    @State var showOutcome = false
    @State var isCorrectAnswer = false
    
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var showAlert = false
    
    @State var score = 0
    @State var round = 1
    
    @State var showGameOver = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .indigo], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            GameArea(choice: getAppChoice(), action: getExpectedAction(), round: round, score: score) { choice in
                check(answer: choice)
            }
            .shadow(radius: 10)
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") {
                    setNextRound()
                }
            } message: {
                Text(alertMessage)
            }.alert("Game Over", isPresented: $showGameOver) {
                Button("OK") {
                    round = 0
                    score = 0
                    showGameOver = false
                }
            } message: {
                Text("Your score: \(score)")
            }
        }
    }
    
    func getAppChoice() -> Choice {
        choices[appChoice]
    }
    
    func getExpectedAction() -> Action {
        actions[expectedAction]
    }
    
    func check(answer: Choice) {
        let outcome = Outcome(app: getAppChoice(), user: answer)
        if getExpectedAction() == outcome.outcome {
            alertTitle = "Correct"
            score += 1
        } else {
            alertTitle = "Wrong"
            alertMessage = "The correct answer is \(outcome.getCorrectAnswer(to: getExpectedAction(), for: getAppChoice()).rawValue)"
            score -= 1
        }
        showAlert = true
    }
    
    func setNextRound() {
        alertTitle = ""
        alertMessage = ""
        showAlert = false
        appChoice = Int.random(in: 0 ..< choices.count)
        expectedAction = Int.random(in: 0 ..< choices.count)
        round += 1
        if round > 10 {
            round = 10
            showGameOver = true
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
