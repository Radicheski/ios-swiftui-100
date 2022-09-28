//
//  ContentView.swift
//  UnitConverter
//
//  Created by Erik Radicheski da Silva on 28/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedConverter: ConverterType = .acceleration
    
    let availableConverters: [ConverterType] = [.acceleration, .angle, .area, .concentrationMass,
                                                .dispersion, .duration, .electricCharge,
                                                .electricCurrent, .electricPotentialDifference,
                                                .electricResistance, .energy, .frequency,
                                                .fuelEfficiency, .illuminance, .informationStorage,
                                                .length, .mass, .power, .pressure, .speed,
                                                .temperature, .volume]
    
    var body: some View {
        Form {
            Section {
                Picker("Select Converter", selection: $selectedConverter) {
                    ForEach(availableConverters, id: \.self) {
                        Text("\($0.id)")
                    }
                }
            }
            Section {
                AnyView(getView())
            }
        }
    }
    
    private func getView() -> any View {
        switch selectedConverter {
        case .acceleration:
            return AccelerationView()
        case .angle:
            return AngleView()
        case .area:
            return AreaView()
        case .concentrationMass:
            return ConcentrationMassView()
        case .dispersion:
            return DispersitionView()
        case .duration:
            return DurationView()
        case .electricCharge:
            return ElectricChargeView()
        case .electricCurrent:
            return ElectricCurrentView()
        case .electricPotentialDifference:
            return ElectricPotentialDifferenceView()
        case .electricResistance:
            return ElectricResistanceView()
        case .energy:
            return EnergyView()
        case .frequency:
            return FrequencyView()
        case .fuelEfficiency:
            return FuelEfficiencyView()
        case .illuminance:
            return IlluminanceView()
        case .informationStorage:
            return InformationStorageView()
        case .length:
            return LengthView()
        case .mass:
            return MassView()
        case .power:
            return PowerView()
        case .pressure:
            return PressureView()
        case .speed:
            return SpeedView()
        case .temperature:
            return TemperatureView()
        case .volume:
            return VolumeView()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum ConverterType: Identifiable {
    var id: String { String(describing: self) }
    
    case acceleration
    case angle
    case area
    case concentrationMass
    case dispersion
    case duration
    case electricCharge
    case electricCurrent
    case electricPotentialDifference
    case electricResistance
    case energy
    case frequency
    case fuelEfficiency
    case illuminance
    case informationStorage
    case length
    case mass
    case power
    case pressure
    case speed
    case temperature
    case volume
    
}
