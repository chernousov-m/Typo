//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 06.05.2021.
//

import Foundation
import Typo

/// Simple storage for testing purposes
final class DictionaryStorage: Storage {
    var dictionary: [String: Data]
    
    init() {
        dictionary = [:]
    }
    
    subscript(_ key: String) -> Data? {
        get { dictionary[key] }
        set { dictionary[key] = newValue }
    }
}
