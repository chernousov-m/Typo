//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 02.05.2021.
//

import Foundation

private extension String {
    static var foundation: String { "Foundation." }
}

// MARK: - AffineTransform

#if os(macOS)
extension AffineTransform: Value {
    public static var typeIdentifier: String = .foundation + "AffineTransform"
}
#endif

// MARK: - Calendar

extension Calendar: Value {
    public static var typeIdentifier: String = .foundation + "Calendar"
}

// MARK: - CharacterSet

extension CharacterSet: Value {
    public static var typeIdentifier: String = .foundation + "CharacterSet"
}

// MARK: - Data

extension Data: Value {
    public static var typeIdentifier: String = .foundation + "Data"
}

// MARK: - Date

extension Date: Value {
    public static var typeIdentifier: String = .foundation + "Date"
}

// MARK: - DateComponents

extension DateComponents: Value {
    public static var typeIdentifier: String = .foundation + "DateComponents"
}

// MARK: - DateInterval

@available(iOS 10.0, OSX 10.12, watchOS 3.0, tvOS 10.0, *)
extension DateInterval: Value {
    public static var typeIdentifier: String = .foundation + "DateInterval"
}

// MARK: - Decimal

extension Decimal: Value {
    public static var typeIdentifier: String = .foundation + "Decimal"
}

// MARK: - IndexPath

extension IndexPath: Value {
    public static var typeIdentifier: String = .foundation + "IndexPath"
}

// MARK: - IndexSet

extension IndexSet: Value {
    public static var typeIdentifier: String = .foundation + "IndexSet"
}

// MARK: - Locale

extension Locale: Value {
    public static var typeIdentifier: String = .foundation + "Locale"
}

// MARK: - Measurement

@available(iOS 10.0, OSX 10.12, watchOS 3.0, tvOS 10.0, *)
extension Measurement: Value where UnitType: Value {
    public static var typeIdentifier: String { .foundation + "Measurement<\(UnitType.typeIdentifier)>" }
}

// MARK: - PersonNameComponents

@available(OSX 10.11, *)
extension PersonNameComponents: Value {
    public static var typeIdentifier: String = .foundation + "PersonNameComponents"
}

// MARK: - TimeZone

extension TimeZone: Value {
    public static var typeIdentifier: String = .foundation + "TimeZone"
}

// MARK: - URL

extension URL: Value {
    public static var typeIdentifier: String = .foundation + "URL"
}

// MARK: - URLComponents

extension URLComponents: Value {
    public static var typeIdentifier: String = .foundation + "URLComponents"
}

// MARK: - UUID

extension UUID: Value {
    public static var typeIdentifier: String = .foundation + "UUID"
}
