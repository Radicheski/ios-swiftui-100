//
//  Activity.swift
//  KeepGoing
//
//  Created by Erik Radicheski da Silva on 11/10/22.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    var title: String
    var counter = 0
}
