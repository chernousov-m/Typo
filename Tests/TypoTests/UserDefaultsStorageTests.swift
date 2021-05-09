//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 06.05.2021.
//

import Foundation
import Typo
import XCTest

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

final class UserDefaultsStorageTests: XCTestCase {
    override func setUp() {
        UserDefaults.standard
            .dictionaryRepresentation()
            .keys
            .forEach(UserDefaults.standard.removeObject(forKey:))
    }

    func testUserDefaults() {
        // Arrange
        let key = "key"
        let data = Data(repeating: 0, count: 10)
        let storage: Storage = UserDefaults.standard
        
        // Act
        XCTAssertEqual(storage[key], nil)
        storage[key] = data
        let stored = storage[key]
        
        // Assert
        XCTAssertEqual(stored, data)
    }
}

#endif
