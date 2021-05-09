//
//  File.swift
//  
//
//  Created by Chernousov Maxim on 06.05.2021.
//

import Foundation

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if canImport(UIKit)
import UIKit
#endif

import Typo
import XCTest

@available(iOS 10.0, OSX 10.12, watchOS 3.0, tvOS 10.0, *)
private final class TestUnit: Unit, Value {
    static var typeIdentifier: String { "TypoTests.TestUnit" }
    
    init(from decoder: Decoder) throws {
        throw NSError()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TypeIdentifiersTests: XCTestCase {
    func testSwiftTypes() {
        XCTAssertEqual(
            Array<Int>.typeIdentifier,
            "Swift.Array<Swift.Int>"
        )
        XCTAssertEqual(
            Bool.typeIdentifier,
            "Swift.Bool"
        )
        XCTAssertEqual(
            ClosedRange<Int>.typeIdentifier,
            "Swift.ClosedRange<Swift.Int>"
        )

        if #available(iOS 13, OSX 10.15, watchOS 6, tvOS 13, *) {
            XCTAssertEqual(
                CollectionDifference<Int>.typeIdentifier,
                "Swift.CollectionDifference<Swift.Int>"
            )
            XCTAssertEqual(
                CollectionDifference<Int>.Change.typeIdentifier,
                "Swift.CollectionDifference<Swift.Int>.Change"
            )
        }
        
        XCTAssertEqual(
            ContiguousArray<Int>.typeIdentifier,
            "Swift.ContiguousArray<Swift.Int>"
        )
        XCTAssertEqual(
            Dictionary<String, Int>.typeIdentifier,
            "Swift.Dictionary<Swift.String, Swift.Int>"
        )
        XCTAssertEqual(
            Double.typeIdentifier,
            "Swift.Double"
        )
        XCTAssertEqual(
            Float.typeIdentifier,
            "Swift.Float"
        )
        #if !os(macOS)
        if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            XCTAssertEqual(
                Float16.typeIdentifier,
                "Swift.Float16"
            )
        }
        #endif
        XCTAssertEqual(
            Int.typeIdentifier,
            "Swift.Int"
        )
        XCTAssertEqual(
            Int8.typeIdentifier,
            "Swift.Int8"
        )
        XCTAssertEqual(
            Int16.typeIdentifier,
            "Swift.Int16"
        )
        XCTAssertEqual(
            Int32.typeIdentifier,
            "Swift.Int32"
        )
        XCTAssertEqual(
            Int64.typeIdentifier,
            "Swift.Int64"
        )
        XCTAssertEqual(
            Optional<Int>.typeIdentifier,
            "Swift.Optional<Swift.Int>"
        )
        XCTAssertEqual(
            PartialRangeFrom<Int>.typeIdentifier,
            "Swift.PartialRangeFrom<Swift.Int>"
        )
        XCTAssertEqual(
            PartialRangeThrough<Int>.typeIdentifier,
            "Swift.PartialRangeThrough<Swift.Int>"
        )
        XCTAssertEqual(
            PartialRangeUpTo<Int>.typeIdentifier,
            "Swift.PartialRangeUpTo<Swift.Int>"
        )
        XCTAssertEqual(
            Range<Int>.typeIdentifier,
            "Swift.Range<Swift.Int>"
        )
        XCTAssertEqual(
            Set<Int>.typeIdentifier,
            "Swift.Set<Swift.Int>"
        )
        XCTAssertEqual(
            String.typeIdentifier,
            "Swift.String"
        )
        XCTAssertEqual(
            UInt.typeIdentifier,
            "Swift.UInt"
        )
        XCTAssertEqual(
            UInt8.typeIdentifier,
            "Swift.UInt8"
        )
        XCTAssertEqual(
            UInt16.typeIdentifier,
            "Swift.UInt16"
        )
        XCTAssertEqual(
            UInt32.typeIdentifier,
            "Swift.UInt32"
        )
        XCTAssertEqual(
            UInt64.typeIdentifier,
            "Swift.UInt64"
        )
    }
    
    func testFoundationTypes() {
        #if os(macOS)
            XCTAssertEqual(
                AffineTransform.typeIdentifier,
                "Foundation.AffineTransform"
            )
        #endif
        XCTAssertEqual(
            Calendar.typeIdentifier,
            "Foundation.Calendar"
        )
        XCTAssertEqual(
            CharacterSet.typeIdentifier,
            "Foundation.CharacterSet"
        )
        XCTAssertEqual(
            Data.typeIdentifier,
            "Foundation.Data"
        )
        XCTAssertEqual(
            Date.typeIdentifier,
            "Foundation.Date"
        )
        XCTAssertEqual(
            DateComponents.typeIdentifier,
            "Foundation.DateComponents"
        )
        if #available(iOS 10.0, OSX 10.12, watchOS 3.0, tvOS 10.0, *) {
            XCTAssertEqual(
                DateInterval.typeIdentifier,
                "Foundation.DateInterval"
            )
        }
        XCTAssertEqual(
            Decimal.typeIdentifier,
            "Foundation.Decimal"
        )
        XCTAssertEqual(
            IndexPath.typeIdentifier,
            "Foundation.IndexPath"
        )
        XCTAssertEqual(
            IndexSet.typeIdentifier,
            "Foundation.IndexSet"
        )
        XCTAssertEqual(
            Locale.typeIdentifier,
            "Foundation.Locale"
        )
        if #available(iOS 10.0, OSX 10.12, watchOS 3.0, tvOS 10.0, *) {
            XCTAssertEqual(
                Measurement<TestUnit>.typeIdentifier,
                "Foundation.Measurement<\(TestUnit.typeIdentifier)>"
            )
        }
        if #available(OSX 10.11, *) {
            XCTAssertEqual(
                PersonNameComponents.typeIdentifier,
                "Foundation.PersonNameComponents"
            )
        }
        XCTAssertEqual(
            TimeZone.typeIdentifier,
            "Foundation.TimeZone"
        )
        XCTAssertEqual(
            URL.typeIdentifier,
            "Foundation.URL"
        )
        XCTAssertEqual(
            URLComponents.typeIdentifier,
            "Foundation.URLComponents"
        )
        XCTAssertEqual(
            UUID.typeIdentifier,
            "Foundation.UUID"
        )
    }
    
    #if canImport(CoreGraphics)
    func testCoreGraphicsTypes() {
        XCTAssertEqual(
            CGAffineTransform.typeIdentifier,
            "CoreGraphics.CGAffineTransform"
        )
        XCTAssertEqual(
            CGFloat.typeIdentifier,
            "CoreGraphics.CGFloat"
        )
        XCTAssertEqual(
            CGPoint.typeIdentifier,
            "CoreGraphics.CGPoint"
        )
        XCTAssertEqual(
            CGRect.typeIdentifier,
            "CoreGraphics.CGRect"
        )
        XCTAssertEqual(
            CGSize.typeIdentifier,
            "CoreGraphics.CGSize"
        )
        XCTAssertEqual(
            CGVector.typeIdentifier,
            "CoreGraphics.CGVector"
        )
    }
    #endif
    
    #if canImport(UIKit)
    func testUIKitTypes() {
        if #available(iOS 11.0, watchOS 4.0, tvOS 11.0, *) {
            XCTAssertEqual(
                NSDirectionalEdgeInsets.typeIdentifier,
                "UIKit.NSDirectionalEdgeInsets"
            )
        }
        XCTAssertEqual(
            UIEdgeInsets.typeIdentifier,
            "UIKit.UIEdgeInsets"
        )
        
        #if !os(watchOS)
        XCTAssertEqual(
            UIFloatRange.typeIdentifier,
            "UIKit.UIFloatRange"
        )
        #endif
        
        XCTAssertEqual(
            UIOffset.typeIdentifier,
            "UIKit.UIOffset"
        )
    }
    #endif
}
