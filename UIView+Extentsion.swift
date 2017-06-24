//
//  UIView+Extentsion.swift
//  UserExperienceExercise
//
//  Created by Coach Roebuck on 6/23/17.
//  Copyright © 2017 Coach Roebuck. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
