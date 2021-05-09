//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 18.04.2021.
//

import Foundation

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

extension UserDefaults: Storage {
    public subscript(key: String) -> Data? {
        get { data(forKey: key) }
        set { setValue(newValue, forKey: key) }
    }
}

#endif
