//
//  OnboardingViewController.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onTapSignIn(sender: AnyObject) {
        self.performSegueWithIdentifier(SegueKey.ReplaceSignIn.rawValue, sender: self)
    }
    
    @IBAction func onTapSignUp(sender: AnyObject) {
        self.performSegueWithIdentifier(SegueKey.ReplaceSignUp.rawValue, sender: self)
    }
    
}
