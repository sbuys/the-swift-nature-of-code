//
//  SignInViewController.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onTapDismiss(sender: AnyObject) {
        self.performSegueWithIdentifier(SegueKey.UnwindReplaceSignIn.rawValue, sender: self)
    }
    
}
