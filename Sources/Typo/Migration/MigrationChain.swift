//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 17.04.2021.
//

import Foundation

/// Migration chain
public struct MigrationChain<Result: Value> {
    // The property is internal to use synthesized initializer
    /// Underlying chain
    internal let chain: MigrationChainLink
}

// MARK: - Migration

public extension MigrationChain {
    /// Add another migration to the chain
    /// - Parameter migration: Migration from the `ResultType` to `NewType`
    /// - Returns: New migration chain
    func migrate<NewType>(
        migration: @escaping (Result) -> NewType
    ) -> MigrationChain<NewType> {
        .init(
            chain: MigrationChainLinkConcrete(
                migration: migration,
                subsequentLinks: chain
            )
        )
    }
}

extension MigrationChain: MigrationChainLink {
    func attemptMigration<Result>(data: Data, to type: Result.Type) -> Result? {
        chain.attemptMigration(data: data, to: Result.self)
    }
}
