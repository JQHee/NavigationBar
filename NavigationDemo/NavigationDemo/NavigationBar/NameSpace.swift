//
//  NameSpace.swift
//  NavigationDemo
//
//  Created by midland on 2019/4/17.
//  Copyright © 2019年 midland. All rights reserved.
//

public final class NVNameSpace<Base> {
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
public protocol NVCompatible {
    /// Extended type
    associatedtype CompatibleType
    
    /// NVNameSpace extensions.
    static var nv: NVNameSpace<CompatibleType>.Type { get }
    
    /// NVNameSpace extensions.
    var nv: NVNameSpace<CompatibleType> { get }
}

extension NVCompatible {
    /// NVNameSpace extensions.
    public static var nv: NVNameSpace<Self>.Type {
        return NVNameSpace<Self>.self
    }
    
    /// NVNameSpace extensions.
    public var nv: NVNameSpace<Self> {
        return NVNameSpace(self)
    }
}

import class Foundation.NSObject

/// Extend NSObject with `FDNameSpace` proxy.
extension NSObject: NVCompatible {}

