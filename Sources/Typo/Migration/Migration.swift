//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 10.04.2021.
//

import Foundation

/// Migration struct to define initial type for a migration chain
public struct Migration<InitalType: Value> {
    /// Initializer
    /// - Parameter initialType: Initial type of a migration chain
    public init(initialType: InitalType.Type) {}
}

// MARK: - MigrationChain creation

public extension Migration {
    /// Create a migration chain
    /// - Parameter migration: Migration handler from `InitialType` to `NewType`
    /// - Returns: Migration chain
    func migrate<NewType>(
        migration: @escaping (InitalType) -> NewType
    ) -> MigrationChain<NewType> {
        .init(
            chain: MigrationChainLinkConcrete(
                migration: migration,
                subsequentLinks: nil
            )
        )
    }
}
