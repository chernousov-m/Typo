//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 17.04.2021.
//

import Foundation

/// Protocol for migration chain link
protocol MigrationChainLink {
    /// Attempt migration to the `Result` type
    func attemptMigration<Result>(data: Data, to type: Result.Type) -> Result?
}

// MARK: - MigrationChainLinkConcrete

/// Concrete implementation of the `MigrationChainLink` protocol
struct MigrationChainLinkConcrete<OldValue: Value, NewValue: Value> {
    /// Migration handler
    let migration: (OldValue) -> NewValue
    /// The rest of the migration chain
    let subsequentLinks: MigrationChainLink?
}

// MARK: - MigrationChainLinkConcrete: MigrationChainLink

extension MigrationChainLinkConcrete: MigrationChainLink {
    func attemptMigration<Result>(data: Data, to type: Result.Type) -> Result? {
        guard Result.self == NewValue.self else { return nil }
        
        let decoder = Typealiases.Decoder()
        
        let oldValue: OldValue?
        if let decoded = try? decoder.decode(ValueWrapper<OldValue>.self, from: data) {
            oldValue = decoded.value
        } else {
            oldValue = subsequentLinks?.attemptMigration(data: data, to: OldValue.self)
        }
        
        return oldValue.map(migration) as? Result
    }
}
