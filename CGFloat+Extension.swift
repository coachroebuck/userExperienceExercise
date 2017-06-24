//
//  CGFloat+Extension.swift
//  UserExperienceExercise
//
//  Created by Coach Roebuck on 6/24/17.
//  Copyright © 2017 Coach Roebuck. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
