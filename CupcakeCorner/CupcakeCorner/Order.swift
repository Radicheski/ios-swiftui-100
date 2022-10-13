//
//  Order.swift
//  CupcakeCorner
//
//  Created by Erik Radicheski da Silva on 12/10/22.
//

import SwiftUI

class Order: ObservableObject, Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var order = OrderWrapee()
    
    enum CodingKeys: CodingKey {
        case order
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decode(OrderWrapee.self, forKey: .order)
    }
    
    init() {}
}

struct OrderWrapee: Codable {
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        guard name.trimmingCharacters(in: .whitespaces).isEmpty == false else { return false }
        guard streetAddress.trimmingCharacters(in: .whitespaces).isEmpty == false else { return false }
        guard city.trimmingCharacters(in: .whitespaces).isEmpty == false else { return false }
        guard zip.trimmingCharacters(in: .whitespaces).isEmpty == false else { return false }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
}
