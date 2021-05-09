//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 06.05.2021.
//

import Foundation
import Typo
import XCTest

final class PropertyDefaultValueTests: XCTestCase {
    override func setUp() {
        Namespace<NS1>.numberOfEvaluations = 0
    }

    func testLazyEvaluation() {
        // Arrange
        let valueToSet = 0
        let storage = DictionaryStorage()
        let proxy = StorageProxy(
            namespaceTag: NS1.self,
            storage: storage
        )
        
        // Act
        proxy.property = valueToSet
        let value = proxy.property
        
        // Assert
        XCTAssertEqual(Namespace<NS1>.numberOfEvaluations, .zero)
        XCTAssertEqual(value, valueToSet)
    }
    
    func testDefaultValueComputesOnce() {
        // Arrange
        let storage = DictionaryStorage()
        let proxy = StorageProxy(
            namespaceTag: NS1.self,
            storage: storage
        )
        
        // Act

        // Read multiple times to see how many times the default value computation is preformed
        var mutableValue = proxy.property
        mutableValue = proxy.property
        mutableValue = proxy.property
        
        let value = mutableValue
        
        // Assert
        XCTAssertEqual(Namespace<NS1>.numberOfEvaluations, 1)
        XCTAssertEqual(value, Namespace<NS1>.defaultValueToProvide)
    }
    
    func testDefaultValueForOptionalTypes() {
        // Arrange
        let storage = DictionaryStorage()
        let proxy = StorageProxy(
            namespaceTag: NS1.self,
            storage: storage
        )
        
        // Act
        let value = proxy.optionalProperty
        
        // Assert
        XCTAssertEqual(value, nil)
    }
}

private enum NS1: NamespaceTag {}

private extension Namespace where Tag == NS1 {
    /// Number of defaultValue computations
    static var numberOfEvaluations = 0
    static let defaultValueToProvide = 1
    
    private static func defaultValue() -> Int {
        defer { numberOfEvaluations += 1}
        
        return defaultValueToProvide
    }

    var property: Property<Int> {
        .init(default: Self.defaultValue())
    }
    
    var optionalProperty: Property<Int?> {
        .init()
    }
}
