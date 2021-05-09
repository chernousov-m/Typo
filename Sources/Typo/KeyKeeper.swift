//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 09.05.2021.
//

import Foundation

@dynamicMemberLookup
public struct KeyKeeper<Tag: NamespaceTag> {
    /// Key transromation to use
    private let keyTransformation: (String) -> String
    /// Key prefix
    private let keyPrefix: String
    
    internal init(
        keyTransformation: @escaping (String) -> String,
        keyPrefix: String
    ) {
        self.keyTransformation = keyTransformation
        self.keyPrefix = keyPrefix
    }
}

public extension KeyKeeper {
    subscript<NewTag>(
        dynamicMember namespaceKeypath: KeyPath<Namespace<Tag>, Namespace<NewTag>>
    ) -> KeyKeeper<NewTag> {
        .init(
            keyTransformation: keyTransformation,
            keyPrefix: keyPrefix
                .appending(keyPrefix.isEmpty ? String.empty : .namespaceSeparator)
                .appending(namespace[keyPath: namespaceKeypath].name)
        )
    }
    
    subscript<Base>(
        dynamicMember propertyKeypath: KeyPath<Namespace<Tag>, Property<Base>>
    ) -> String {
        let property = namespace[keyPath: propertyKeypath]
        return keyTransformation(
            keyPrefix
                .appending(keyPrefix.isEmpty ? String.empty : .propertySeparator)
                .appending(property.name)
        )
    }
}

private extension KeyKeeper {
    /// Current namespace property for convenience
    var namespace: Namespace<Tag> {
        .init(name: .empty)
    }
}
