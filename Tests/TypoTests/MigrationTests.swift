//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 06.05.2021.
//

import Foundation
import Typo
import XCTest

final class MigrationTests: XCTestCase {
    func testWholeChainMigration() {
        // Arrange
        typealias Namespace = Typo.Namespace<NS>
        let storage = DictionaryStorage()
        let proxy = StorageProxy(
            namespaceTag: NS.self,
            storage: storage
        )
        
        // Act
        let initialValue = 1
        proxy.intProp = initialValue
        let result = proxy.stringProperty
        
        let int64 = Namespace.intToInt64Migration(initialValue)
        let double = Namespace.int64ToDoubleMigration(int64)
        let string = Namespace.doubleToStringMigration(double)
        
        // Assert
        XCTAssertEqual(result, string)
    }
    
    func testMigrationFromUnsuitableType() {
        // Arrange
        typealias Namespace = Typo.Namespace<NS>
        let storage = DictionaryStorage()
        let proxy = StorageProxy(
            namespaceTag: NS.self,
            storage: storage
        )
        // Act
        _ = proxy.nonOptionalIntProperty
        
        let result = proxy.stringProperty
        
        // Assert
        XCTAssertEqual(result, nil) // the defaultValue
    }
    
    func testPartialMigration() {
        // Arrange
        typealias Namespace = Typo.Namespace<NS>
        let storage = DictionaryStorage()
        let proxy = StorageProxy(
            namespaceTag: NS.self,
            storage: storage
        )
        
        do {
            // Act
            let initialValue: Int64 = 1
            proxy.int64Prop = initialValue
            let result = proxy.stringProperty
            
            let double = Namespace.int64ToDoubleMigration(initialValue)
            let string = Namespace.doubleToStringMigration(double)
            
            // Assert
            XCTAssertEqual(result, string)
        }
        
        do {
            // Act
            let initialValue: Double = 1
            proxy.doubleProperty = initialValue
            let result = proxy.stringProperty
            
            let string = Namespace.doubleToStringMigration(initialValue)
            
            // Assert
            XCTAssertEqual(result, string)
        }
    }
}

private enum NS: NamespaceTag {}

private extension Namespace where Tag == NS {
    // All of the properties will have the same key to test migrations
    static let propertyName = "prop"
    
    var nonOptionalIntProperty: Property<Int> {
        .init(default: 0, name: Self.propertyName)
    }

    var intProp: Property<Int?> {
        .init(name: Self.propertyName)
    }
    
    var int64Prop: Property<Int64?> {
        .init(name: Self.propertyName)
    }
    
    var doubleProperty: Property<Double?> {
        .init(name: Self.propertyName)
    }
    
    var stringProperty: Property<String?> {
        Property(name: Self.propertyName)
            .migration(
                Migration(initialType: Optional<Int>.self)
                    .migrate(migration: Self.intToInt64Migration(_:))
                    .migrate(migration: Self.int64ToDoubleMigration(_:))
                    .migrate(migration: Self.doubleToStringMigration(_:))
            )
    }
    
    static func intToInt64Migration(_ int: Int?) -> Int64? {
        int.map { Int64($0 * 2) }
    }
    
    static func int64ToDoubleMigration(_ int64: Int64?) -> Double? {
        int64.map { Double($0 * 2) }
    }
    
    static func doubleToStringMigration(_ double: Double?) -> String? {
        double.map { String($0 * 2) }
    }
}
