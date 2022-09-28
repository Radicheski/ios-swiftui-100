//
//  InformationStorageView.swift
//  UnitConverter
//
//  Created by Erik Radicheski da Silva on 28/09/22.
//

import SwiftUI

struct InformationStorageView: View {
    
    @State private var valueOne = 0.0
    @State private var unitOne: UnitInformationStorage = .baseUnit()
    @State private var valueTwo = 0.0
    @State private var unitTwo: UnitInformationStorage = .baseUnit()
    
    let options: [UnitInformationStorage] = [.kilobits, .kibibits, .megabits, .mebibits,
                                             .gigabits, .gibibits, .terabits, .tebibits,
                                             .petabits, .pebibits, .exabits, .exbibits,
                                             .zettabits, .zebibits, .yottabits, .yobibits,
                                             .kilobytes, .kibibytes, .megabytes, .mebibytes,
                                             .gigabytes, .gibibytes, .terabytes, .tebibytes,
                                             .petabytes, .pebibytes, .exabytes, .exbibytes,
                                             .zettabytes, .zebibytes, .yottabytes, .yobibytes]
    
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

struct InformationStorageView_Previews: PreviewProvider {
    static var previews: some View {
        InformationStorageView()
    }
}
