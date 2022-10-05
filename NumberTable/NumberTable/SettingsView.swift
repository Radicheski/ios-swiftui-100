//
//  SettingsView.swift
//  NumberTable
//
//  Created by Erik Radicheski da Silva on 05/10/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var number: Int
    @Binding var numberOfQuestions: Int
    var range: ClosedRange<Int>
    var onSubmit: () -> Void
    
    var body: some View {
        VStack {
            Text("What number you want to try?")
            Stepper("\(number)", value: $number, in: 2 ... 10)
                .padding()
            Spacer(minLength: 20)
            Text("How many questions?")
            Stepper("\(numberOfQuestions) questions", value: $numberOfQuestions, in: range)
                .padding()
            Spacer(minLength: 20)
            Button("Start game", action: onSubmit)
        }
        .padding()
        .frame(width: 300, height: 300)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView(number: .constant(5), numberOfQuestions: .constant(5), range: 5 ... 20) { }
    }
}
