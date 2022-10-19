//
//  ExpenseView.swift
//  iExpense
//
//  Created by Erik Radicheski da Silva on 06/10/22.
//

import SwiftUI

struct ExpenseView: View {
    
    let type: String
    @ObservedObject var expenses: Expenses
    var items: [ExpenseItem] {
        expenses.getItems(for: type)
    }
    
    private struct Line: View {
        let item: ExpenseItem
        
        var body: some View {
            HStack {
                VStack {
                    Text(item.name)
                        .font(.headline)
                }
                Spacer()
                Text(item.amount, format: Format.curency)
                    .foregroundColor(item.amount > 100 ? .red : (item.amount < 10 ? .green : nil))
            }
            .accessibilityElement()
            .accessibilityLabel("\(item.name), \(item.amount, format: Format.curency)")
            .accessibilityHint(item.type)
        }
    }
    
    var body: some View {
        Section(type) {
            ForEach(items) { item in
                Line(item: item)
            }
            .onDelete(perform: removeItems)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.remove(ids: offsets.map { items[$0].id } )
    }
    
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(type: "Personal", expenses: Expenses())
    }
}
