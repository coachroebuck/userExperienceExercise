//
//  InfoView.swift
//  UserExperienceExercise
//
//  Created by Coach Roebuck on 6/23/17.
//  Copyright © 2017 Coach Roebuck. All rights reserved.
//

import UIKit

class InfoView: UIView {

    var rootStackView : UIStackView!
    var stackViews = [UIStackView]()
    var totalRows : Int!
    var totalColumns : Int!
    var isExpanded : Bool = false
    var selectedRow : CGFloat = 0
    var selectedColumn : CGFloat  = 0
    var trailingMultiplier : CGFloat = 0
    var bottomMultiplier : CGFloat = 0
    
    class func initWithConfiguration(totalRows: Int,
                                     totalColumns: Int) -> InfoView {
        let infoView : InfoView = InfoView()
        infoView.totalColumns = totalColumns
        infoView.totalRows = totalRows
        infoView.initialize()
        return infoView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialize() {
        let oneFloat : CGFloat = 1
        let tCols = CGFloat.init(self.totalColumns)
        let tRows = CGFloat.init(self.totalRows)
        let colDivisor = oneFloat * tCols
        let rowDivisor = oneFloat * tRows
        trailingMultiplier = isExpanded ? oneFloat : colDivisor
        bottomMultiplier = isExpanded ? oneFloat : rowDivisor
        
        self.backgroundColor = .random()
        self.rootStackView = UIStackView()
        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.rootStackView)
        NSLayoutConstraint.fill(self.rootStackView
            , parentView: self, leftOffset: 0
            , rightOffset: 0
            , topOffset: 0
            , bottomOffset: 0)
        
        self.rootStackView.axis = UILayoutConstraintAxis.vertical
        self.rootStackView.distribution = UIStackViewDistribution.fillEqually
        self.rootStackView.alignment = UIStackViewAlignment.fill
        
        for _ in 1...totalRows {
            let nextStackView : UIStackView = UIStackView()
            nextStackView.axis = UILayoutConstraintAxis.horizontal
            nextStackView.distribution = UIStackViewDistribution.fillEqually
            nextStackView.alignment = UIStackViewAlignment.fill
            
            for _ in 1...totalColumns {
                let nextView = UIView()
                nextStackView.addArrangedSubview(nextView)
                nextView.backgroundColor = .random()
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
                tap.delegate = self as? UIGestureRecognizerDelegate
                nextView.addGestureRecognizer(tap)
                
                let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDown(_:)))
                swipeDown.direction = (.down)
                nextView.addGestureRecognizer(swipeDown)
            }
            self.rootStackView.addArrangedSubview(nextStackView)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func rotated(_ sender: Any) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
        if(self.isExpanded) {
            changeConstraints()
            self.superview?.layoutIfNeeded()
        }
    }
    
    func tapBlurButton(_ sender: UITapGestureRecognizer) {
        let view : UIView? = sender.view
        drillDown(view: view);
    }
    
    func swipeDown(_ sender: UITapGestureRecognizer) {
        let view : UIView? = sender.view
        drillDown(view: view);
    }
    
    func swipeUp(_ sender: UITapGestureRecognizer) {
        let view : UIView? = sender.view
        drillUp(view: view);
    }
    
    func drillDown(view : UIView?) {
        if(!isExpanded) {
            var isFound = false
            
            //We must find the row and column of the selected view
            selectedRow = 0
            for case let nextStackView as UIStackView in self.rootStackView.arrangedSubviews {
                selectedColumn = 0
                for case let nextView in nextStackView.arrangedSubviews {
                    if(view?.isEqual(nextView))! {
                        isFound = true
                        break
                    }
                    else {
                        selectedColumn = selectedColumn + 1
                    }
                }
                
                if(isFound) {
                    break
                }
                else {
                    selectedRow = selectedRow + 1
                }
            }
            
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeUp(_:)))
            swipeUp.direction = (.up)
            view?.addGestureRecognizer(swipeUp)

            UIView.transition(with: view!, duration: 0.5, options: .curveEaseInOut, animations: {() -> Void in
                let infoView = InfoView.initWithConfiguration(totalRows: 3, totalColumns: 3)
                infoView.translatesAutoresizingMaskIntoConstraints = false
                view?.addSubview(infoView);
                NSLayoutConstraint.fill(infoView, parentView: view!
                    , leftOffset: 0, rightOffset: 0, topOffset: 0, bottomOffset: 0)
                view?.layoutIfNeeded()
            }, completion: { _ in })
            
            changeConstraints()
            
            UIView.animate(withDuration: 0.5, animations: {
                self.superview?.layoutIfNeeded()
            }) { (result : Bool) in
                self.isExpanded = !self.isExpanded
            }
        }
    }
    
    private func getWidth() -> CGFloat {
        if(UIDevice.current.orientation.isLandscape) {
            return self.frame.size.width > self.frame.size.height ? self.frame.size.width : self.frame.size.height
        }
        else {
            return self.frame.size.width < self.frame.size.height ? self.frame.size.width : self.frame.size.height
        }
    }
    
    private func getHeight() -> CGFloat {
        if(UIDevice.current.orientation.isLandscape) {
            return self.frame.size.width < self.frame.size.height ? self.frame.size.width : self.frame.size.height
        }
        else {
            return self.frame.size.width > self.frame.size.height ? self.frame.size.width : self.frame.size.height
        }
    }
    
    private func changeConstraints() {
        let width = getWidth()
        let height = getHeight()
        let leftConstant = CGFloat.init(width * (selectedColumn) * -1)
        let topConstant = CGFloat.init(height * (selectedRow) * -1)
        let rightConstant = leftConstant
        let bottomConstant = topConstant
        
        print("constants=(\(leftConstant), \(topConstant), \(rightConstant), \(bottomMultiplier)) "
            + "multiplier=\(trailingMultiplier) \(bottomMultiplier)")
        
        self.removeConstraints(self.constraints)
        
        var constraint: NSLayoutConstraint? = nil
        constraint = NSLayoutConstraint(item: self.rootStackView,
                                        attribute: .left,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .left,
                                        multiplier: 1,
                                        constant: leftConstant)
        constraint?.identifier = "left"
        self.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: self.rootStackView,
                                        attribute: .right,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .right,
                                        multiplier: trailingMultiplier,
                                        constant: rightConstant)
        constraint?.identifier = "right"
        self.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: self.rootStackView,
                                        attribute: .top,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .top,
                                        multiplier: 1,
                                        constant: topConstant)
        constraint?.identifier = "top"
        self.addConstraint(constraint!)
        constraint = NSLayoutConstraint(item: self.rootStackView,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .bottom,
                                        multiplier: bottomMultiplier,
                                        constant: bottomConstant)
        constraint?.identifier = "bottom"
        self.addConstraint(constraint!)
    }
    
    func drillUp(view : UIView?) {
        if(isExpanded) {
            
            self.removeConstraints(self.constraints)
            
            NSLayoutConstraint.fill(self.rootStackView
                , parentView: self, leftOffset: 0
                , rightOffset: 0
                , topOffset: 0
                , bottomOffset: 0)
            
            for case let childView in (view?.subviews)! {
                UIView.animate(withDuration: 0.5, animations: {
                    childView.alpha = 0.0
                },
                                           completion: { (value: Bool) in
                                            childView.removeFromSuperview()
                })
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.superview?.layoutIfNeeded()
            }) { (result : Bool) in
                self.isExpanded = !self.isExpanded
            }
        }
    }
}
