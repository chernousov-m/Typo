//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 17.04.2021.
//

import Foundation

public extension Property {
    /// Add migration to the property
    /// - Parameter migrationChain: Migration chain
    /// - Returns: New property with a given migration
    func migration(_ migrationChain: @escaping @autoclosure () -> MigrationChain<Base>) -> Self {
        .init(
            name: name,
            defaultValue: defaultValue,
            migrationChain: migrationChain
        )
    }
}
