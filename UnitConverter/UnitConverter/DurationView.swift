//
//  DurationView.swift
//  UnitConverter
//
//  Created by Erik Radicheski da Silva on 28/09/22.
//

import SwiftUI

struct DurationView: View {
    
    @State private var valueOne = 0.0
    @State private var unitOne: UnitDuration = .baseUnit()
    @State private var valueTwo = 0.0
    @State private var unitTwo: UnitDuration = .baseUnit()
    
    let options: [UnitDuration] = [.seconds, .minutes, .hours]
    
    var body: some View {
        Section {
            HStack {
                TextField("Dimension A",
                          value: $valueOne,
                          format: .number)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .onChange(of: valueTwo) {
                    valueOne = convert(value: $0, from: unitTwo, to: unitOne)
                }
                .onChange(of: unitTwo) {
                    valueOne = convert(value: valueTwo, from: $0, to: unitOne)
                }
                Spacer()
                Picker("Unit A", selection: $unitOne) {
                    ForEach(options, id: \.self) {
                        Text("\($0.symbol)")
                    }
                }
                .labelsHidden()
            }
            HStack {
                TextField("Dimension B",
                          value: $valueTwo,
                          format: .number)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .onChange(of: valueOne) {
                    valueTwo = convert(value: $0, from: unitOne, to: unitTwo)
                }
                .onChange(of: unitOne) {
                    valueTwo = convert(value: valueOne, from: $0, to: unitTwo)
                }
                Spacer()
                Picker("Unit A", selection: $unitTwo) {
                    ForEach(options, id: \.self) {
                        Text("\($0.symbol)")
                    }
                }
                .labelsHidden()
            }
        }
    }
    
    private func convert(value: Double, from unitOne: Dimension, to unitTwo: Dimension) -> Double {
        var measurement = Measurement(value: value, unit: unitOne)
        measurement.convert(to: unitTwo)
        return measurement.value
    }
    
}

struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        DurationView()
    }
}
