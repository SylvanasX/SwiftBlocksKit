//
//  SwiftBlocksKit.swift
//  BL
//
//  Created by sy on 2017/9/24.
//  Copyright © 2017年 sy. All rights reserved.
//

import UIKit

public struct SwiftBlocksKit<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SwiftBlocksKitCompatible {
    associatedtype CompatibleType
    static var sb: SwiftBlocksKit<CompatibleType>.Type { get }
    var sb: SwiftBlocksKit<CompatibleType> { get }
}

public extension SwiftBlocksKitCompatible {
    static var sb: SwiftBlocksKit<Self>.Type {
        return SwiftBlocksKit<Self>.self
    }
    
    var sb: SwiftBlocksKit<Self> {
        get { return SwiftBlocksKit(self) }
    }
}

extension UIControl: SwiftBlocksKitCompatible {}
extension Timer: SwiftBlocksKitCompatible {}
