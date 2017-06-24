//
//  UIColor+Extension.swift
//  UserExperienceExercise
//
//  Created by Coach Roebuck on 6/24/17.
//  Copyright © 2017 Coach Roebuck. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
