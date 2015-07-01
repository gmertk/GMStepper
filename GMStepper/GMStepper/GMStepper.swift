//
//  GMStepper.swift
//  GMStepper
//
//  Created by Gunay Mert Karadogan on 1/7/15.
//  Copyright © 2015 Gunay Mert Karadogan. All rights reserved.
//

import UIKit

public class GMStepper: UIControl {
    public var value = 0 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
            label.text = String(value)
            
            if oldValue != value {
                sendActionsForControlEvents(.ValueChanged)
            }
        }
    }
    
    public var minimumValue = 0
    public var maximumValue = 10
    
    public var leftButtonText = "-"
    public var rightButtonText = "+"
    
    public var buttonsTextColor = UIColor.whiteColor()
    
    public var buttonsBackgroundColor = UIColor(red:0.21, green:0.5, blue:0.74, alpha:1)
    
    public var buttonsFont = UIFont(name: "AvenirNext-Bold", size: 20.0)!
    
    public var labelTextColor = UIColor.whiteColor()
    
    public var labelBackgroundColor = UIColor(red:0.26, green:0.6, blue:0.87, alpha:1)

    public var labelFont = UIFont(name: "AvenirNext-Bold", size: 25.0)!
    
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private let label = UILabel()
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        leftButton.setTitle(leftButtonText, forState: [.Normal])
        leftButton.setTitleColor(buttonsTextColor, forState: [.Normal])
        leftButton.backgroundColor = buttonsBackgroundColor
        leftButton.titleLabel?.font = buttonsFont
        leftButton.addTarget(self, action: "leftButtonTapped:", forControlEvents: .TouchDown)
        addSubview(leftButton)
        
        rightButton.setTitle(rightButtonText, forState: [.Normal])
        rightButton.setTitleColor(buttonsTextColor, forState: [.Normal])
        rightButton.backgroundColor = buttonsBackgroundColor
        rightButton.titleLabel?.font = buttonsFont
        rightButton.addTarget(self, action: "rightButtonTapped:", forControlEvents: .TouchDown)
        addSubview(rightButton)
        
        label.textAlignment = .Center
        label.text = String(value)
        label.textColor = labelTextColor
        label.backgroundColor = labelBackgroundColor
        label.font = labelFont
        addSubview(label)
        
        backgroundColor = UIColor.grayColor()

    }
    
    public override func layoutSubviews() {
        let buttonWidth = bounds.size.width * 0.25
        let labelWidth = bounds.size.width * 0.5
        
        leftButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: bounds.size.height)
        label.frame = CGRect(x: buttonWidth, y: 0, width: labelWidth, height: bounds.size.height)
        rightButton.frame = CGRect(x: labelWidth + buttonWidth, y: 0, width: buttonWidth, height: bounds.size.height)
    }
    
    @objc private func leftButtonTapped(button: UIButton) {
        value -= 1
    }

    @objc private func rightButtonTapped(button: UIButton) {
        value += 1
    }
}
