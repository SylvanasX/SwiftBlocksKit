//
//  UIGestureRecognizer+SwiftBlocksKit.swift
//  Pods-SwiftBlocksKit_Example
//
//  Created by Sylvanas on 25/09/2017.
//

import UIKit

public typealias GestureRecognizerHandlerBlock = (UIGestureRecognizer, UIGestureRecognizerState, CGPoint) -> Void
private var swiftBlocksKitGestureRecognizerWrapperKey: Void?

extension SwiftBlocksKit where Base: UIGestureRecognizer {
    public static func recognizerWithHandler(_ handler: @escaping GestureRecognizerHandlerBlock, delay: TimeInterval = 0.0) -> Base {
        let target = SwiftBlocksKitGestureRecognizerWrapper(handler, delay: delay)
        let obj = Base(target: target, action: .hanlder)
        objc_setAssociatedObject(obj, &swiftBlocksKitGestureRecognizerWrapperKey, target, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return obj
    }
}

private extension Selector {
    static let hanlder = #selector(SwiftBlocksKitGestureRecognizerWrapper.handleAction(recognizer:))
}

fileprivate class SwiftBlocksKitGestureRecognizerWrapper: NSObject {
    
    var block: GestureRecognizerHandlerBlock?
    let delay: TimeInterval
    init(_ block: @escaping GestureRecognizerHandlerBlock, delay: TimeInterval) {
        self.block = block
        self.delay = delay
    }
    
    @objc func handleAction(recognizer: UIGestureRecognizer) {
        guard let block = block else { return }
        let location = recognizer.location(in: recognizer.view);
        let state = recognizer.state
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            block(recognizer, state, location)
        }
    }
}

