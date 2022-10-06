//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Erik Radicheski da Silva on 06/10/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
