//
//  ViewController.swift
//  GMStepper
//
//  Created by Gunay Mert Karadogan on 1/7/15.
//  Copyright © 2015 Gunay Mert Karadogan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stepper: GMStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.addTarget(self, action: "stepperValueChanged:", forControlEvents: .ValueChanged)
    }
    
    func stepperValueChanged(stepper: GMStepper) {
        print(stepper.value)
    }
}

