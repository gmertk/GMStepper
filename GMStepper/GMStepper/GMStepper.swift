//
//  GMStepper.swift
//  GMStepper
//
//  Created by Gunay Mert Karadogan on 1/7/15.
//  Copyright © 2015 Gunay Mert Karadogan. All rights reserved.
//

import UIKit

class GMStepper: UIView {
    var value = 0 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
            label.text = String(value)
        }
    }
    
    var minimumValue = 0
    var maximumValue = 10
    
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
        
        label.textAlignment = .Center
        label.text = String(value)
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        let labelWidth = Int(frame.size.width) - 2 * buttonSize

        let leftButtonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        let labelFrame = CGRect(x: buttonSize, y: 0, width: labelWidth, height: buttonSize)
        let rightButtonFrame = CGRect(x: buttonSize + labelWidth, y: 0, width: buttonSize, height: buttonSize)
        
        leftButton.frame = leftButtonFrame
        label.frame = labelFrame
        rightButton.frame = rightButtonFrame
    }
    
    func leftButtonTapped(button: UIButton) {
        value -= 1
    }

    func rightButtonTapped(button: UIButton) {
        value += 1
    }
}
