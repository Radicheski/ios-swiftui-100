//
//  ContentView.swift
//  NumberTable
//
//  Created by Erik Radicheski da Silva on 05/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isGameActive = false
    @State private var number = 2
    @State private var numberOfQuestions = 5
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .indigo], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            if isGameActive {
                GameView(number: number, numberOfQuestions: numberOfQuestions, onFinish: endGame)
            } else {
                SettingsView(number: $number,
                             numberOfQuestions: $numberOfQuestions,
                             range: 5 ... 20,
                             onSubmit: startGame)
            }
        }
    }
    
    func startGame() {
        isGameActive = true
    }
    
    func endGame() {
        isGameActive = false
        number = Int.random(in: 2 ... 10)
        numberOfQuestions = Int.random(in: 5 ... 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
