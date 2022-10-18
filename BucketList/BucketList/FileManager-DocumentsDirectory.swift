//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Erik Radicheski da Silva on 18/10/22.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
