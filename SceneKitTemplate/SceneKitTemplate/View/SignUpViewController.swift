//
//  SignUpViewController.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onTapDismiss(sender: AnyObject) {
        self.performSegueWithIdentifier(SegueKey.UnwindReplaceSignUp.rawValue, sender: self)
    }
    
}
