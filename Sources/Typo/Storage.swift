//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 17.04.2021.
//

import Foundation

/// A protocol for storage, compatible with `Typo`
public protocol Storage: AnyObject {
    subscript(_ key: String) -> Data? { get set }
}
