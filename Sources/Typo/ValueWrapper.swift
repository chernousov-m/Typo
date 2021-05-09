//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 17.04.2021.
//

import Foundation

/// Internal wrapper around a codable value. It's used to decode/encode wrapped value to `Data`, and enforce type-safety
struct ValueWrapper<Value: Typo.Value> {
    private let valueRepresentation: ValueRepresentation
    
    /// Main intializer
    /// - Parameter value: Wrapped value
    init(value: Value) {
        valueRepresentation = .init(
            type: Value.typeIdentifier,
            value: value
        )
    }
    
    /// A property to get access to wrapped value
    var value: Value {
        valueRepresentation.value
    }
}

// MARK: - Private

private extension ValueWrapper {
    /// Underlying value representation
    struct ValueRepresentation: Codable {
        /// Type of the value - `String(describing: Value.self)`
        let type: String
        /// The value
        let value: Value
    }
}

// MARK: - Codable

// Custom Codable implementation allows checking type and avoiding extra nesting layer,
// which is present in ValueWrapper
extension ValueWrapper: Codable {
    enum DecodingError: Error {
        /// If the type of the decoded value does not match the one we expect,
        /// even if they are interchangable (Int8/Int16/etc are the same when represented by JSON),
        /// we throw this error
        case typeMismatch
    }

    init(from decoder: Decoder) throws {
        let data = try ValueRepresentation(from: decoder)
        
        // Check if the type of the decoded value is the type we expect
        guard data.type == Value.typeIdentifier else { throw DecodingError.typeMismatch }

        self.valueRepresentation = data
    }
    
    func encode(to encoder: Encoder) throws {
        try valueRepresentation.encode(to: encoder)
    }
}
