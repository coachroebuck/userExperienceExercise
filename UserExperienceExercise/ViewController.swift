//
//  ViewController.swift
//  UserExperienceExercise
//
//  Created by Coach Roebuck on 6/23/17.
//  Copyright © 2017 Coach Roebuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var infoView : InfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView = InfoView.initWithConfiguration(totalRows: 3, totalColumns: 3)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(infoView);
        NSLayoutConstraint.fill(infoView, parentView: self.view
            , leftOffset: 0, rightOffset: 0, topOffset: 0, bottomOffset: 0)
        self.view.layoutIfNeeded()
    }
}

