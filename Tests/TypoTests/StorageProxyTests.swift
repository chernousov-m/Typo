//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 04.05.2021.
//

import Foundation
import Typo
import XCTest

final class StorageProxyTests: XCTestCase {
    func testReturnsDefaultValueWhenNoValueIsPresentInStorage() {
        // Arrange
        let storage = DictionaryStorage()
        let proxy = StorageProxy(
            namespaceTag: NS2.self,
            storage: storage
        )
        
        // Act
        let value = proxy.prop
        
        // Assert
        XCTAssertEqual(value, 0)
    }
    
    func testReturnsDefaultValueWhenDecodingFails() {
        // Arrange
        let storage = DictionaryStorage()
        storage.dictionary["prop"] = Data()
        
        let proxy = StorageProxy(
            namespaceTag: NS2.self,
            storage: storage
        )
        
        // Act
        let value = proxy.prop
        
        // Assert
        XCTAssertEqual(value, Namespace<NS2>.defaultValue)
    }
    
    func testSetValue() {
        // Arrange
        let storage = DictionaryStorage()
        let proxy = StorageProxy(
            namespaceTag: NS2.self,
            storage: storage
        )
        
        // Act
        proxy.ns1.ns2.prop = 1
        
        // Assert
        XCTAssertEqual(proxy.ns1.ns2.prop, 1)
    }
}

private enum NS1: NamespaceTag {}

private enum NS2: NamespaceTag {}

private extension Namespace where Tag == NS1 {
    var ns2: Namespace<NS2> { .init(tag: NS2.self) }
}

private extension Namespace where Tag == NS2 {
    var ns1: Namespace<NS1> { .init() }
    
    var prop: Property<Int> { .init(default: Self.defaultValue) }
    
    static var defaultValue = 0
}
