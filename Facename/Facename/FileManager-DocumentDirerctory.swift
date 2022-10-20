//
//  FileManager-DocumentDirerctory.swift
//  Facename
//
//  Created by Erik Radicheski da Silva on 20/10/22.
//

import Foundation

extension FileManager {
    
    var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
}
