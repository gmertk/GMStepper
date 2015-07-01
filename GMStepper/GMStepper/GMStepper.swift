//
//  GMStepper.swift
//  GMStepper
//
//  Created by Gunay Mert Karadogan on 1/7/15.
//  Copyright © 2015 Gunay Mert Karadogan. All rights reserved.
//

import UIKit

public class GMStepper: UIView {
    public var value = 0 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
            label.text = String(value)
        }
    }
    
    public var minimumValue = 0
    
    public var maximumValue = 10
    
    
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private let label = UILabel()
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        leftButton.setTitle("-", forState: [.Normal])
        rightButton.setTitle("+", forState: [.Normal])
        
        leftButton.addTarget(self, action: "leftButtonTapped:", forControlEvents: .TouchDown)
        rightButton.addTarget(self, action: "rightButtonTapped:", forControlEvents: .TouchDown)
        
        label.textAlignment = .Center
        label.text = String(value)
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(label)
        
        backgroundColor = UIColor.grayColor()
        label.backgroundColor = UIColor.redColor()
        leftButton.backgroundColor = UIColor.purpleColor()
        rightButton.backgroundColor = UIColor.purpleColor()
    }
    
    public override func layoutSubviews() {
        let buttonWidth = bounds.size.width * 0.25
        let labelWidth = bounds.size.width * 0.5
        
        leftButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: bounds.size.height)
        label.frame = CGRect(x: buttonWidth, y: 0, width: labelWidth, height: bounds.size.height)
        rightButton.frame = CGRect(x: labelWidth + buttonWidth, y: 0, width: buttonWidth, height: bounds.size.height)
    }
    
    private func leftButtonTapped(button: UIButton) {
        value -= 1
    }

    private func rightButtonTapped(button: UIButton) {
        value += 1
    }
}
