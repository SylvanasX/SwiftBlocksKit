//
//  UIView+SwiftBlocksKit.swift
//  Pods-SwiftBlocksKit_Example
//
//  Created by Sylvanas on 25/09/2017.
//

import UIKit

extension SwiftBlocksKit where Base: UIView {
    public func whenTouchesNumberOfTouches(numberOfTouches: Int, tapped: Int, handler: @escaping () -> Void) {
        let gesture = UITapGestureRecognizer.sb.recognizerWithHandler({ (sender, state, location) in
            if state == .recognized {
                handler()
            }
        }, delay: 0.0)
        gesture.numberOfTouchesRequired = numberOfTouches
        gesture.numberOfTapsRequired = tapped
        base.gestureRecognizers?.forEach({
            guard let tap = $0 as? UITapGestureRecognizer else { return }

            let rightTouches = (tap.numberOfTouches == numberOfTouches)
            let rightTaps = (tap.numberOfTapsRequired == tapped)
        
            if rightTouches && rightTaps {
                gesture.require(toFail: tap)
            }
        })
        
        base.addGestureRecognizer(gesture)
    }
    
    public func whenTappd(_ handler: @escaping () -> Void) {
        whenTouchesNumberOfTouches(numberOfTouches: 1, tapped: 1, handler: handler)
    }
    
    public func whenDoubleTapped(_ handler: @escaping () -> Void) {
        whenTouchesNumberOfTouches(numberOfTouches: 1, tapped: 2, handler: handler)
    }
    
    public func eachSubview(_ handler: (UIView) -> Void) {
        base.subviews.forEach { (subview) in
            handler(subview)
        }
    }
}
