//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 02.05.2021.
//

#if canImport(UIKit)

import UIKit

private extension String {
    static var uiKit: String { "UIKit." }
}

// MARK: - NSDirectionalEdgeInsets

@available(iOS 11.0, watchOS 4.0, tvOS 11.0, *)
extension NSDirectionalEdgeInsets: Value {
    public static var typeIdentifier: String = .uiKit + "NSDirectionalEdgeInsets"
}

// MARK: - UIEdgeInsets

extension UIEdgeInsets: Value {
    public static var typeIdentifier: String = .uiKit + "UIEdgeInsets"
}

#if !os(watchOS)
// MARK: - UIFloatRange

extension UIFloatRange: Value {
    public static var typeIdentifier: String = .uiKit + "UIFloatRange"
}

#endif

// MARK: - UIOffset

extension UIOffset: Value {
    public static var typeIdentifier: String = .uiKit + "UIOffset"
}

#endif
