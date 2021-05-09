//
//  Namespace.swift
//  
//
//  Created by Chernousov Maxim on 10.04.2021.
//

import Foundation

/// Namespace descriptor
public struct Namespace<Tag: NamespaceTag> {
    /// Name to use in storage keys
    internal let name: String

    /// Convenience initializer
    /// - Parameters:
    ///   - tag: NamespaceTag to use
    ///   - name: Name to use in storage keys
    public init(
        tag: Tag.Type,
        name: String = #function
    ) {
        self.init(name: name)
    }
    
    /// Main initializer
    /// - Parameter name: Name to use in storage keys
    public init(name: String = #function) {
        self.name = name
    }
}
