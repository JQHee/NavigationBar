//
//  NameSpace.swift
//  NavigationDemo
//
//  Created by midland on 2019/4/17.
//  Copyright © 2019年 midland. All rights reserved.
//

public final class FOLDin<Base> {
    /// Base object to extend.
    public let base: Base
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has FOLDin extensions.
public protocol FOLDinCompatible {
    /// Extended type
    associatedtype CompatibleType
    
    /// FOLDin extensions.
    static var fd: FOLDin<CompatibleType>.Type { get }
    
    /// FOLDin extensions.
    var fd: FOLDin<CompatibleType> { get }
}

extension FOLDinCompatible {
    /// FOLDin extensions.
    public static var fd: FOLDin<Self>.Type {
        return FOLDin<Self>.self
    }
    
    /// FOLDin extensions.
    public var fd: FOLDin<Self> {
        return FOLDin(self)
    }
}

import class Foundation.NSObject

/// Extend NSObject with `FOLDin` proxy.
extension NSObject: FOLDinCompatible {}
