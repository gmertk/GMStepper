//
//  GMStepper.swift
//  GMStepper
//
//  Created by Gunay Mert Karadogan on 1/7/15.
//  Copyright © 2015 Gunay Mert Karadogan. All rights reserved.
//

import UIKit

@IBDesignable public class GMStepper: UIControl {
    
    /// Current value of the stepper. Defaults to 0.
    public var value = 0 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
            label.text = String(value)
            
            if oldValue != value {
                sendActionsForControlEvents(.ValueChanged)
            }
        }
    }
    
    /// Minimum value. Must be less than maximumValue. Defaults to 0.
    @IBInspectable public var minimumValue: Int = 0 {
        didSet {
            value = 0
        }
    }
    
    /// Maximum value. Must be more than minimumValue. Defaults to 10.
    @IBInspectable public var maximumValue: Int = 10 {
        didSet {
            value = 0
        }
    }
    
    /// Text on the left button. Be sure that it fits in the button. Defaults to "-".
    @IBInspectable public var leftButtonText: String = "-" {
        didSet {
            leftButton.setTitle(leftButtonText, forState: .Normal)
        }
    }
    
    /// Text on the right button. Be sure that it fits in the button. Defaults to "+".
    @IBInspectable public var rightButtonText: String = "+" {
        didSet {
            rightButton.setTitle(rightButtonText, forState: .Normal)
        }
    }
    
    /// Text color of the buttons. Defaults to white.
    @IBInspectable public var buttonsTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            for button in [leftButton, rightButton] {
                button.setTitleColor(buttonsTextColor, forState: .Normal)
            }
        }
    }
    
    /// Background color of the buttons. Defaults to dark blue.
    @IBInspectable public var buttonsBackgroundColor: UIColor = UIColor(red:0.21, green:0.5, blue:0.74, alpha:1) {
        didSet {
            for button in [leftButton, rightButton] {
                button.backgroundColor = buttonsBackgroundColor
            }
            backgroundColor = buttonsBackgroundColor
        }
    }
    
    /// Font of the buttons. Defaults to AvenirNext-Bold, 20.0 points in size.
    public var buttonsFont = UIFont(name: "AvenirNext-Bold", size: 20.0)! {
        didSet {
            for button in [leftButton, rightButton] {
                button.titleLabel?.font = buttonsFont
            }
        }
    }
    
    /// Text color of the middle label. Defaults to white.
    @IBInspectable public var labelTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            label.textColor = labelTextColor
        }
    }
    
    /// Text color of the middle label. Defaults to lighter blue.
    @IBInspectable public var labelBackgroundColor: UIColor = UIColor(red:0.26, green:0.6, blue:0.87, alpha:1) {
        didSet {
            label.backgroundColor = labelBackgroundColor
        }
    }

    /// Font of the middle label. Defaults to AvenirNext-Bold, 25.0 points in size.
    public var labelFont = UIFont(name: "AvenirNext-Bold", size: 25.0)! {
        didSet {
            label.font = labelFont
        }
    }
    
    /// Corner radius of the stepper's layer. Defaults to 4.0.
    @IBInspectable public var cornerRadius: CGFloat = 4.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    /// Percentage of the middle label's width. Must be between 0 and 1. Defaults to 0.5. Be sure that it is wide enough to show the value.
    @IBInspectable public var labelWidthWeight: CGFloat = 0.5 {
        didSet {
            labelWidthWeight = min(1, max(0, labelWidthWeight))
            setNeedsLayout()
        }
    }
    
    /**
        Width of the sliding animation. When buttons clicked, the middle label does a slide animation towards to the clicked button. Defaults to 5.
    */
    private let labelSlideLength: CGFloat = 5
    
    /// Duration of the sliding animation
    private let labelSlideDuration: NSTimeInterval = 0.1
    
    /// Duration of the flashing animation when the value hits the limit.
    private let limitHitAnimationDuration: NSTimeInterval = 0.1
    
    /// Color of the flashing animation on the buttons in case the value hit the limit.
    @IBInspectable public var limitHitAnimationColor: UIColor = UIColor(red:0.26, green:0.6, blue:0.87, alpha:1)
    
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
        leftButton.setTitle(leftButtonText, forState: .Normal)
        leftButton.setTitleColor(buttonsTextColor, forState: .Normal)
        leftButton.backgroundColor = buttonsBackgroundColor
        leftButton.titleLabel?.font = buttonsFont
        leftButton.addTarget(self, action: "leftButtonTapped:", forControlEvents: .TouchDown)
        addSubview(leftButton)
        
        rightButton.setTitle(rightButtonText, forState: .Normal)
        rightButton.setTitleColor(buttonsTextColor, forState: .Normal)
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
        let buttonWidth = bounds.size.width * ((1 - labelWidthWeight) / 2)
        let labelWidth = bounds.size.width * labelWidthWeight
        
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
