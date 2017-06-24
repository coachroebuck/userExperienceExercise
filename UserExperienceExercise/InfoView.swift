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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialize() {
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
            let oneFloat : CGFloat = 1
            let tCols = CGFloat.init(self.totalColumns)
            let tRows = CGFloat.init(self.totalRows)
            let colDivisor = oneFloat * tCols
            let rowDivisor = oneFloat * tRows
            let trailingMultiplier : CGFloat = isExpanded ? oneFloat : colDivisor
            let bottomMultiplier : CGFloat = isExpanded ? oneFloat : rowDivisor
            var selectedRow : CGFloat = 0
            var selectedColumn : CGFloat  = 0
            var isFound = false
            
            //We must find the row and column of the selected view
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
            
            self.removeConstraints(self.constraints)
            
            let leftConstant = CGFloat.init(self.frame.size.width * (selectedColumn) * -1)
            let topConstant = CGFloat.init(self.frame.size.height * (selectedRow) * -1)
            let rightConstant = leftConstant
            let bottomConstant = topConstant
            
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
            
            UIView.animate(withDuration: 0.5, animations: {
                self.superview?.layoutIfNeeded()
            }) { (result : Bool) in
                self.isExpanded = !self.isExpanded
            }
        }
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
    
    class func initWithConfiguration(totalRows: Int,
                                     totalColumns: Int) -> InfoView {
        let infoView : InfoView = InfoView()
        infoView.totalColumns = totalColumns
        infoView.totalRows = totalRows
        infoView.initialize()
        return infoView
    }
}
