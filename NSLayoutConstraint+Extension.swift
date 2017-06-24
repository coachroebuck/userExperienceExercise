//
//  NSLayoutConstraint+Extension.swift
//  UserExperienceExercise
//
//  Created by Coach Roebuck on 6/23/17.
//  Copyright © 2017 Coach Roebuck. All rights reserved.
//

import Foundation
import UIKit
//  The converted code is limited by 4 KB.
//  Upgrade your plan to remove this limitation.

//  Converted with Swiftify v1.0.6381 - https://objectivec2swift.com/
extension NSLayoutConstraint {
    class func rightAlignView(_ targetView: UIView, to otherView: UIView, offset: CGFloat, parentView: UIView) {
        parentView.addConstraint(NSLayoutConstraint(item: targetView, attribute: .right, relatedBy: .equal, toItem: otherView, attribute: .right, multiplier: 1.0, constant: offset))
    }
    
    class func leftAlignView(_ targetView: UIView, to otherView: UIView, offset: CGFloat, parentView: UIView) {
        parentView.addConstraint(NSLayoutConstraint(item: targetView, attribute: .left, relatedBy: .equal, toItem: otherView, attribute: .left, multiplier: 1.0, constant: offset))
    }
    
    class func center(_ view: UIView, parentView: UIView) {
        NSLayoutConstraint.verticallyCenter(view, parentView: parentView)
        NSLayoutConstraint.horizontallyCenter(view, parentView: parentView)
    }
    
    class func verticallyCenter(_ view: UIView, parentView: UIView) {
        self.verticallyCenter(view, parentView: parentView, offset: 0)
    }
    
    class func verticallyCenter(_ view: UIView, parentView: UIView, offset: CGFloat) {
        parentView.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: parentView, attribute: .centerY, multiplier: 1.0, constant: offset))
    }
    
    class func horizontallyCenter(_ view: UIView, parentView: UIView) -> Void {
        self.horizontallyCenter(view, parentView: parentView, offset: 0)
    }
    
    class func horizontallyCenter(_ view: UIView, parentView: UIView, offset: CGFloat) -> Void {
        let constraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: parentView, attribute: .centerX, multiplier: 1.0, constant: offset)
        parentView.addConstraint(constraint)
    }
    
    class func rightAlignView(_ targetView: UIView, parentView: UIView, offset: CGFloat) {
        parentView.addConstraint(NSLayoutConstraint(item: targetView, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1.0, constant: offset))
    }
    
    class func leftAlignView(_ targetView: UIView, parentView: UIView, offset: CGFloat) {
        parentView.addConstraint(NSLayoutConstraint(item: targetView, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1.0, constant: offset))
    }
    
    class func bottomAlignView(_ targetView: UIView, parentView: UIView, offset: CGFloat) {
        parentView.addConstraint(NSLayoutConstraint(item: targetView, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: offset))
    }
    
    class func topAlignView(_ view: UIView, to toView: UIView, constraintOwner: UIView, offset: CGFloat) {
        constraintOwner.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: 1.0, constant: offset))
    }
    
    class func addHeightConstraint(to view: UIView, height: CGFloat) {
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height))
    }
    
    class func addWidthConstraint(to view: UIView, width: CGFloat) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint?
        constraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
        view.addConstraint(constraint!)
        return constraint!
    }
    
    class func addSizeConstraint(to view: UIView, width: CGFloat, height: CGFloat) {
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height))
    }
    
    class func fill(_ view: UIView, parentView: UIView, leftOffset: CGFloat, rightOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat) {
        NSLayoutConstraint.fill(view, parentView: parentView, leftOffset: leftOffset, rightOffset: rightOffset, topOffset: topOffset, bottomOffset: bottomOffset, multiplier: 1.0)
    }
    
    class func fill(_ view: UIView, parentView: UIView, leftOffset: CGFloat, rightOffset: CGFloat, topOffset: CGFloat, bottomOffset: CGFloat, multiplier: CGFloat) {
        var constraint: NSLayoutConstraint? = nil
        constraint = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: multiplier, constant: leftOffset)
        constraint?.identifier = "left"
        parentView.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: multiplier, constant: rightOffset)
        constraint?.identifier = "right"
        parentView.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: multiplier, constant: topOffset)
        constraint?.identifier = "top"
        parentView.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: multiplier, constant: bottomOffset)
        constraint?.identifier = "bottom"
        parentView.addConstraint(constraint!)
    }
    
    class func alignBottomRight(with view: UIView, parentView: UIView, rightOffset: CGFloat, bottomOffset: CGFloat, width: CGFloat, height: CGFloat) {
        var constraint: NSLayoutConstraint? = nil
        constraint = NSLayoutConstraint(item: view, attribute: .right, relatedBy: NSLayoutRelation.init(rawValue: 0)!, toItem: parentView, attribute: .right, multiplier: 1, constant: rightOffset)
        parentView.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: NSLayoutRelation.init(rawValue: 0)!, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        parentView.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: NSLayoutRelation.init(rawValue: 0)!, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        parentView.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: NSLayoutRelation.init(rawValue: 0)!, toItem: parentView, attribute: .bottom, multiplier: 1, constant: bottomOffset)
        parentView.addConstraint(constraint!)
    }
    
    class func verticallyFill(_ view: UIView, parentView: UIView) {
        var constraint: NSLayoutConstraint? = nil
        constraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: 0)
        parentView.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        parentView.addConstraint(constraint!)
    }
    
    class func horizontallyFill(_ view: UIView, parentView: UIView, offset: CGFloat) {
        var constraint: NSLayoutConstraint? = nil
        constraint = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1.0, constant: offset)
        parentView.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1.0, constant: -offset)
        parentView.addConstraint(constraint!)
    }
    
    class func leadingAlignView(_ view: UIView, to toView: UIView, constraintOwner: UIView, offset: CGFloat) {
        let c = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: 1.0, constant: offset)
        constraintOwner.addConstraint(c)
    }
    
    class func trailingAlignView(_ view: UIView, to toView: UIView, constraintOwner: UIView, offset: CGFloat) {
        let c = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: 1.0, constant: offset)
        constraintOwner.addConstraint(c)
    }
    
    class func alignViewLeading(toTrailing view: UIView, trailingEdgeView: UIView, constraintOwner: UIView, offset: CGFloat) {
        let c = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: trailingEdgeView, attribute: .trailing, multiplier: 1.0, constant: offset)
        constraintOwner.addConstraint(c)
    }
    
    class func alignViewTrailing(toLeading view: UIView, leadingEdgeView: UIView, constraintOwner: UIView, offset: CGFloat) {
        let c = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: leadingEdgeView, attribute: .leading, multiplier: 1.0, constant: offset)
        constraintOwner.addConstraint(c)
    }
    
    class func alignViewTop(toBottom view: UIView, bottomEdgeView: UIView, constraintOwner: UIView, offset: CGFloat) {
        let c = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: bottomEdgeView, attribute: .bottom, multiplier: 1.0, constant: offset)
        constraintOwner.addConstraint(c)
    }
    
    class func alignViewHeight(_ view: UIView, to toView: UIView, constraintOwner: UIView, multiplier: CGFloat, constant: CGFloat) {
        let c = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: toView, attribute: .height, multiplier: multiplier, constant: constant)
        constraintOwner.addConstraint(c)
    }
    
    class func alignViewWidth(_ view: UIView, to toView: UIView, constraintOwner: UIView, multiplier: CGFloat, constant: CGFloat) {
        let c = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: multiplier, constant: constant)
        constraintOwner.addConstraint(c)
    }
}
