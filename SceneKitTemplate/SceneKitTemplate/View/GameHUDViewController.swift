//
//  GameHUDViewController.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit

class GameHUDViewController: UIViewController {

    @IBOutlet weak var outlineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.outlineView.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.outlineView.layer.borderWidth = 1
        
    }
    
}
