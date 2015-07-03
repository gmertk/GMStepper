//
//  GMStepper.swift
//  GMStepper
//
//  Created by Gunay Mert Karadogan on 1/7/15.
//  Copyright © 2015 Gunay Mert Karadogan. All rights reserved.
//

import UIKit

@IBDesignable public class GMStepper: UIControl {
    public var value = 0 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
            label.text = String(value)
            
            if oldValue != value {
                sendActionsForControlEvents(.ValueChanged)
            }
        }
    }
    
    @IBInspectable public var minimumValue: Int = 0 {
        didSet {
            value = 0
        }
    }
    
    @IBInspectable public var maximumValue: Int = 10 {
        didSet {
            value = 0
        }
    }
    
    @IBInspectable public var leftButtonText: String = "-" {
        didSet {
            leftButton.setTitle(leftButtonText, forState: [.Normal])
        }
    }
    
    @IBInspectable public var rightButtonText: String = "+" {
        didSet {
            rightButton.setTitle(rightButtonText, forState: [.Normal])
        }
    }
    
    @IBInspectable public var buttonsTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            for button in [leftButton, rightButton] {
                button.setTitleColor(buttonsTextColor, forState: [.Normal])
            }
        }
    }
    
    @IBInspectable public var buttonsBackgroundColor: UIColor = UIColor(red:0.21, green:0.5, blue:0.74, alpha:1) {
        didSet {
            for button in [leftButton, rightButton] {
                button.backgroundColor = buttonsBackgroundColor
            }
            backgroundColor = buttonsBackgroundColor
        }
    }
    
    public var buttonsFont = UIFont(name: "AvenirNext-Bold", size: 20.0)! {
        didSet {
            for button in [leftButton, rightButton] {
                button.titleLabel?.font = buttonsFont
            }
        }
    }
    
    @IBInspectable public var labelTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            label.textColor = labelTextColor
        }
    }
    
    @IBInspectable public var labelBackgroundColor: UIColor = UIColor(red:0.26, green:0.6, blue:0.87, alpha:1) {
        didSet {
            label.backgroundColor = labelBackgroundColor
        }
    }

    public var labelFont = UIFont(name: "AvenirNext-Bold", size: 25.0)! {
        didSet {
            label.font = labelFont
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 4.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    private let labelSlideLength: CGFloat = 5
    private let labelSlideDuration: NSTimeInterval = 0.1
    
    private let limitHitAnimationDuration: NSTimeInterval = 0.1
    @IBInspectable public var limitHitAnimationColor: UIColor = UIColor(red:0.23, green:0.3, blue:0.51, alpha:1)
    
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private let label = UILabel()
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
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
        
        backgroundColor = buttonsBackgroundColor
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    public override func layoutSubviews() {
        let buttonWidth = bounds.size.width * 0.25
        let labelWidth = bounds.size.width * 0.5
        
        leftButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: bounds.size.height)
        label.frame = CGRect(x: buttonWidth, y: 0, width: labelWidth, height: bounds.size.height)
        rightButton.frame = CGRect(x: labelWidth + buttonWidth, y: 0, width: buttonWidth, height: bounds.size.height)
    }
    
    @objc private func leftButtonTapped(button: UIButton) {
        if value == minimumValue {
            animateLimitHitForButton(leftButton)
        } else {
            value -= 1
            animateSlideLeft()
        }
    }

    @objc private func rightButtonTapped(button: UIButton) {
        if value == maximumValue {
            animateLimitHitForButton(rightButton)
        } else {
            value += 1
            animateSlideRight()
        }
    }
    
    private func animateSlideLeft() {
        UIView.animateWithDuration(labelSlideDuration, animations: {
            self.label.center.x -= self.labelSlideLength
        }, completion: { _ in
            UIView.animateWithDuration(self.labelSlideDuration, animations: {
                self.label.center.x += self.labelSlideLength
            })
        })
    }
    
    private func animateSlideRight() {
        UIView.animateWithDuration(labelSlideDuration, animations: {
            self.label.center.x += self.labelSlideLength
        }, completion: { _ in
            UIView.animateWithDuration(self.labelSlideDuration, animations: {
                self.label.center.x -= self.labelSlideLength
            })
        })
    }
    
    private func animateLimitHitForButton(button: UIButton){
        UIView.animateWithDuration(limitHitAnimationDuration, animations: {
            button.backgroundColor = self.limitHitAnimationColor
        }, completion: { _ in
            button.backgroundColor = self.buttonsBackgroundColor
        })
    }
}
