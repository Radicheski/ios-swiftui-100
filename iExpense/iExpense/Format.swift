//
//  Format.swift
//  iExpense
//
//  Created by Erik Radicheski da Silva on 06/10/22.
//

import Foundation

enum Format {
    
    static var curency: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currency?.identifier ?? "USD"
        return FloatingPointFormatStyle.Currency(code: currencyCode)
    }
    
}
