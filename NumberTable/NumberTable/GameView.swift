//
//  GameView.swift
//  NumberTable
//
//  Created by Erik Radicheski da Silva on 05/10/22.
//

import SwiftUI

struct GameView: View {
    
    let number: Int
    let numberOfQuestions: Int
    let onFinish: () -> Void
    @State private var multiplier = 0
    @State private var options = [Int]()
    
    @State private var presentAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertAction = { }
    
    @State private var questionsAsked = 0
    
    var body: some View {
        VStack {
            Text("\(number) x \(multiplier) = ?")
                .font(.title2)
            Spacer(minLength: 30)
            ForEach(options, id: \.self) { number in
                Button("\(number)") {
                    check(answer: number)
                }
                .frame(width: 150, height: 40)
                .foregroundColor(.primary)
                .background(.purple.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
        .onAppear(perform: showQuestion)
        .alert(alertTitle, isPresented: $presentAlert) {
            Button("OK", action: alertAction)
        } message: {
            Text(alertMessage)
        }
        .padding()
        .frame(width: 300, height: 330)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    func check(answer: Int) {
        if multiplier * number == answer {
            alertTitle = "Well done!"
            alertMessage = "Correct!"
        } else {
            alertTitle = "Not right"
            alertMessage = "\(number) times \(multiplier) is \(multiplier * number)"
        }
        presentAlert = true
        if questionsAsked < numberOfQuestions {
            alertAction = showQuestion
        } else {
            alertAction = onFinish
        }
    }
    
    func showQuestion() {
        multiplier = Int.random(in: 1 ... 10)
        var options = Set<Int>()
        options.insert(multiplier)
        while options.count < 5 {
            options.insert(Int.random(in: 1 ... 10))
        }
        self.options = Array(options).map { number * $0 }.shuffled()
        questionsAsked += 1
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(number: 5, numberOfQuestions: 20) { }
    }
}
