//
//  ContentView.swift
//  BetterRest
//
//  Created by Erik Radicheski da Silva on 02/10/22.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var bedtime = defaultBedtime
    
    static var defaultBedtime: String {
        var components = DateComponents()
        components.hour = 22
        components.minute = 38
        let bedtime = Calendar.current.date(from: components) ?? Date.now
        return bedtime.formatted(date: .omitted, time: .shortened)
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        Spacer()
                    }
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value : $sleepAmount, in: 4 ... 12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }
                
                Section {
                    Picker("How many cups?", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                        .font(.headline)
                }
                
                Section {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("\(bedtime)")
                            .font(.title)
                            .padding()
                        Spacer()
                    }
                } header: {
                    Text("Your ideal bedtime is ...")
                        .font(.title3)
                }
            }
            .navigationTitle("BetterRest")
            .onChange(of: wakeUp, perform: { _ in calculatedBedTime() })
            .onChange(of: sleepAmount, perform: { _ in calculatedBedTime() })
            .onChange(of: coffeeAmount, perform: { _ in calculatedBedTime() })
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculatedBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            bedtime = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
