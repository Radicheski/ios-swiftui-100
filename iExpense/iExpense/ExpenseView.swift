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
    
    var body: some View {
        Section(type) {
            ForEach(items) { item in
                HStack {
                    VStack {
                        Text(item.name)
                            .font(.headline)
                    }
                    Spacer()
                    Text(item.amount, format: Format.curency)
                        .foregroundColor(item.amount > 100 ? .red : (item.amount < 10 ? .green : nil))
                }
                
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
