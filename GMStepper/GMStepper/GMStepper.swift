//
//  GMStepper.swift
//  GMStepper
//
//  Created by Gunay Mert Karadogan on 1/7/15.
//  Copyright © 2015 Gunay Mert Karadogan. All rights reserved.
//

import UIKit

class GMStepper: UIView {
    let leftButton = UIButton()
    let rightButton = UIButton()
    let label = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let leftButtonImage = UIImage(named: "minus")
        let rightButtonImage = UIImage(named: "plus")
        
        rightButton.setImage(rightButtonImage, forState: [.Normal])
        leftButton.setImage(leftButtonImage, forState: [.Normal])
        
        leftButton.addTarget(self, action: "leftButtonTapped:", forControlEvents: .TouchDown)
        rightButton.addTarget(self, action: "rightButtonTapped:", forControlEvents: .TouchDown)
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(label)
    }
}
