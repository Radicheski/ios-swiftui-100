//
//  Expenses.swift
//  iExpense
//
//  Created by Erik Radicheski da Silva on 06/10/22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    func getItems(for type: String) -> [ExpenseItem] {
        items.filter { $0.type == type }
    }
    
    func remove(ids: [UUID]) {
        items.removeAll(where: { ids.contains($0.id) } )
    }
    
}
