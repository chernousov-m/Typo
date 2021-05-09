//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 10.04.2021.
//

import Foundation

/// A property declaration for `Typo`
public struct Property<Base: Value> {
    /// A name for the property to use
    internal let name: String
    /// A default value of the property
    internal let defaultValue: () -> Base
    /// Migration chain (if present). It is lazily created when needed, so a closure is used for it
    internal let migrationChain: (() -> MigrationChain<Base>)?
}

// MARK: - Initializers

public extension Property {
    /// Convenience initializer for optional types. Sets the default value to `nil`
    /// - Parameter name: Name of the property to use in storage keys
    init<T>(
        name: String = #function
    ) where Base == Optional<T> {
        self.init(
            default: nil,
            name: name
        )
    }
    
    /// Main initializer
    /// - Parameters:
    ///   - default: Default value for the property
    ///   - name: Name of the property to use in storage keys
    init(
        default: @escaping @autoclosure () -> Base,
        name: String = #function
    ) {
        self.name = name
        defaultValue = `default`
        migrationChain = nil
    }
}
