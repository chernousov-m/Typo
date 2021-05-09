//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 02.05.2021.
//

private extension String {
    static var swift: String { "Swift." }
}

// MARK: - Array

extension Array: Value where Element: Value {
    public static var typeIdentifier: String { .swift + "Array<\(Element.typeIdentifier)>" }
}

// MARK: - Bool

extension Bool: Value {
    public static var typeIdentifier: String = .swift + "Bool"
}

// MARK: - ClosedRange

extension ClosedRange: Value where Bound: Value {
    public static var typeIdentifier: String { .swift + "ClosedRange<\(Bound.typeIdentifier)>" }
}

// MARK: - CollectionDifference

@available(iOS 13, OSX 10.15, watchOS 6, tvOS 13, *)
extension CollectionDifference: Value where ChangeElement: Value {
    public static var typeIdentifier: String {
        .swift + "CollectionDifference<\(ChangeElement.typeIdentifier)>"
    }
}

// MARK: - CollectionDifference.Change

@available(iOS 13, OSX 10.15, watchOS 6, tvOS 13, *)
extension CollectionDifference.Change where ChangeElement: Value {
    public static var typeIdentifier: String {
        .swift + "CollectionDifference<\(ChangeElement.typeIdentifier)>.Change"
    }
}

// MARK: - ContiguousArray

extension ContiguousArray: Value where Element: Value {
    public static var typeIdentifier: String { .swift + "ContiguousArray<\(Element.typeIdentifier)>" }
}

// MARK: - Dictionary

extension Dictionary: Typo.Value where Key: Typo.Value, Value: Typo.Value {
    public static var typeIdentifier: String {
        .swift + "Dictionary<\(Key.typeIdentifier), \(Value.typeIdentifier)>"
    }
}

// MARK: - Double

extension Double: Value {
    public static var typeIdentifier: String = .swift + "Double"
}

// MARK: - Float

extension Float: Value {
    public static var typeIdentifier: String = .swift + "Float"
}

// MARK: - Float16

@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
@available(macOS, unavailable)
@available(macCatalyst, unavailable)
extension Float16: Value {
    public static var typeIdentifier: String = .swift + "Float16"
}

// MARK: Int

extension Int: Value {
    public static var typeIdentifier: String = .swift + "Int"
}

// MARK: Int8

extension Int8: Value {
    public static var typeIdentifier: String = .swift + "Int8"
}

// MARK: Int16

extension Int16: Value {
    public static var typeIdentifier: String = .swift + "Int16"
}

// MARK: Int32

extension Int32: Value {
    public static var typeIdentifier: String = .swift + "Int32"
}

// MARK: Int64

extension Int64: Value {
    public static var typeIdentifier: String = .swift + "Int64"
}

// MARK: - Optional

extension Optional: Value where Wrapped: Value {
    public static var typeIdentifier: String { .swift + "Optional<\(Wrapped.typeIdentifier)>" }
}

// MARK: - PartialRangeFrom

extension PartialRangeFrom: Value where Bound: Value {
    public static var typeIdentifier: String { .swift + "PartialRangeFrom<\(Bound.typeIdentifier)>" }
}

// MARK: - PartialRangeThrough

extension PartialRangeThrough: Value where Bound: Value {
    public static var typeIdentifier: String { .swift + "PartialRangeThrough<\(Bound.typeIdentifier)>" }
}

// MARK: - PartialRangeUpTo

extension PartialRangeUpTo: Value where Bound: Value {
    public static var typeIdentifier: String { .swift + "PartialRangeUpTo<\(Bound.typeIdentifier)>" }
}

// MARK: - Range

extension Range: Value where Bound: Value {
    public static var typeIdentifier: String { .swift + "Range<\(Bound.typeIdentifier)>" }
}

// MARK: - Set

extension Set: Value where Element: Value {
    public static var typeIdentifier: String { .swift + "Set<\(Element.typeIdentifier)>" }
}

// MARK: String

extension String: Value {
    public static var typeIdentifier: String = .swift + "String"
}

// MARK: UInt

extension UInt: Value {
    public static var typeIdentifier: String = .swift + "UInt"
}

// MARK: UInt8

extension UInt8: Value {
    public static var typeIdentifier: String = .swift + "UInt8"
}

// MARK: UInt16

extension UInt16: Value {
    public static var typeIdentifier: String = .swift + "UInt16"
}

// MARK: UInt32

extension UInt32: Value {
    public static var typeIdentifier: String = .swift + "UInt32"
}

// MARK: UInt64

extension UInt64: Value {
    public static var typeIdentifier: String = .swift + "UInt64"
}
