//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 02.05.2021.
//

import CoreGraphics

// MARK: - CGAffineTransform

extension CGAffineTransform: Value {
    public static var typeIdentifier: String { "CoreGraphics.CGAffineTransform" }
}

// MARK: - CGFloat

extension CGFloat: Value {
    public static var typeIdentifier: String { "CoreGraphics.CGFloat" }
}

// MARK: - CGPoint

extension CGPoint: Value {
    public static var typeIdentifier: String { "CoreGraphics.CGPoint" }
}

// MARK: - CGRect

extension CGRect: Value {
    public static var typeIdentifier: String { "CoreGraphics.CGRect" }
}

// MARK: - CGSize

extension CGSize: Value {
    public static var typeIdentifier: String { "CoreGraphics.CGSize" }
}

// MARK: - CGVector

extension CGVector: Value {
    public static var typeIdentifier: String { "CoreGraphics.CGVector" }
}
