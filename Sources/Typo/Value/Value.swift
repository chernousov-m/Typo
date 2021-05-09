//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 27.04.2021.
//

import Foundation

/// Protocol for values that are supported by Typo
public protocol Value: Codable {
    /// Type identifier string
    static var typeIdentifier: String { get }
}
