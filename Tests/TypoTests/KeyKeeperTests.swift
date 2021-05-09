//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 09.05.2021.
//

import Foundation
import Typo
import XCTest

final class KeyKeeperTests: XCTestCase {
    func testNamespaceChainKey() {
        // Arrange
        let proxy = StorageProxy(
            namespaceTag: NS1.self,
            storage: DictionaryStorage()
        )
        
        do {
            // Assert
            XCTAssertEqual(proxy().ns2.ns1.ns2.prop, "ns2.ns1.ns2/prop")
        }
        
        do {
            // Act
            let keeperKeyPath = \KeyKeeper<NS1>.ns2.ns1.ns2.prop
            
            // Assert
            XCTAssertEqual(proxy()[keyPath: keeperKeyPath], "ns2.ns1.ns2/prop")
        }
    }
    
    func testKeyTransformation() {
        // Arrange
        let prefix = "PREFIX_"
        let proxy = StorageProxy(
            namespaceTag: NS1.self,
            storage: DictionaryStorage(),
            keyTransformation: { prefix + $0 }
        )
        
        // Assert
        XCTAssertTrue(proxy().ns2.ns1.ns2.prop.hasPrefix(prefix))
    }
    
    func testKeyPrefix() {
        // Arrange
        let prefix = "PREFIX_"
        let proxy = StorageProxy(
            namespaceTag: NS1.self,
            storage: DictionaryStorage(),
            keyPrefix: prefix
        )
        
        // Assert
        XCTAssertTrue(proxy().ns2.ns1.ns2.prop.hasPrefix(prefix))
    }
    
    func testEmptyPropertyPrefixInRootNamespace() {
        // Arrange
        let storage = DictionaryStorage()
        let proxy = StorageProxy(
            namespaceTag: NS2.self,
            storage: storage
        )
        
        // Assert
        XCTAssertEqual(proxy().prop, "prop")
    }
}

private enum NS1: NamespaceTag {}

private enum NS2: NamespaceTag {}

private extension Namespace where Tag == NS1 {
    var ns2: Namespace<NS2> { .init(tag: NS2.self) }
}

private extension Namespace where Tag == NS2 {
    var ns1: Namespace<NS1> { .init() }
    
    var prop: Property<Int?> { .init() }
}
