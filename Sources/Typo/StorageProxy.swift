//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 10.04.2021.
//

import Foundation

/// Storage wrapper. Provides convenient access to properties and nested namespaces defined in `Namespace<Tag>`
@dynamicMemberLookup
public struct StorageProxy<Tag: NamespaceTag> {
    /// Underlying storage
    private let storage: Storage
    /// KeyKeeper to get keys for properties
    private let keyKeeper: KeyKeeper<Tag>
}

// MARK: - API

public extension StorageProxy {
    /// Call it to get KeyKeeper object to get keys for properties if needed
    func callAsFunction() -> KeyKeeper<Tag> {
        keyKeeper
    }

    subscript<NewTag>(
        dynamicMember namespaceKeypath: KeyPath<Namespace<Tag>, Namespace<NewTag>>
    ) -> StorageProxy<NewTag> {
        .init(
            storage: storage,
            keyKeeper: keyKeeper[dynamicMember: namespaceKeypath]
        )
    }
    
    subscript<Base>(
        dynamicMember propertyKeypath: KeyPath<Namespace<Tag>, Property<Base>>
    ) -> Base {
        get {
            getValue(for: propertyKeypath)
        }
        nonmutating set {
            set(newValue, key: keyKeeper[dynamicMember: propertyKeypath])
        }
    }
}

// MARK: - Initialization

public extension StorageProxy {
    /// Main initializer
    /// - Parameters:
    ///   - namespaceTag: Namespace tag to use
    ///   - storage: Underlying storage
    ///   - keyPrefix: Key prefix
    ///   - keyTransformation: Key transformation
    init(
        namespaceTag: Tag.Type = Tag.self,
        storage: Storage,
        keyPrefix: String = "",
        keyTransformation: @escaping (String) -> String = { $0 }
    ) {
        self.storage = storage
        self.keyKeeper = .init(keyTransformation: keyTransformation, keyPrefix: keyPrefix)
    }
}

// MARK: - Private

private extension StorageProxy {
    /// Current namespace property for convenience
    var namespace: Namespace<Tag> {
        .init(name: .empty)
    }

    func getValue<Base: Value>(for keyPath: KeyPath<Namespace<Tag>, Property<Base>>) -> Base {
        let key = keyKeeper[dynamicMember: keyPath]
        let property = namespace[keyPath: keyPath]

        guard let data = storage[key] else {
            let defaultValue = property.defaultValue()
            set(defaultValue, key: key)
            return defaultValue
        }
        
        let decoder = Typealiases.Decoder()
        
        let value: Base
        if let decoded = try? decoder.decode(ValueWrapper<Base>.self, from: data) {
            value = decoded.value
        } else {
            if let migrated = property.migrationChain?().attemptMigration(data: data, to: Base.self) {
                value = migrated
            } else {
                value = property.defaultValue()
            }
            // Set the value to prevent future migration attempts or default value computations
            set(value, key: key)
        }
        
        return value
    }
    
    /// Set the value for the given key
    /// - Parameters:
    ///   - value: Value to set
    ///   - key: Key to use
    func set<Base: Value>(_ value: Base, key: String) {
        let encoder = Typealiases.Encoder()
        storage[key] = try? encoder.encode(ValueWrapper(value: value))
    }
}
