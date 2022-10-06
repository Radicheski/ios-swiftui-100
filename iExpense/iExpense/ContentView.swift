//
//  ContentView.swift
//  iExpense
//
//  Created by Erik Radicheski da Silva on 06/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ExpenseView(type: "Business", expenses: expenses)
                ExpenseView(type: "Personal", expenses: expenses)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
