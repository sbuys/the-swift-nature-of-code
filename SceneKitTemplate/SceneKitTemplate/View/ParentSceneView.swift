//
//  ParentSceneView.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class ParentSceneView: SCNView, SceneControllerViewDelegate {

    override init(frame: CGRect, options: [String : AnyObject]?) {
        super.init(frame: frame, options: options)
        self.backgroundColor = UIColor.clearColor()
        self.allowsCameraControl = false
        self.autoenablesDefaultLighting = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SceneControlViewDelegate
    
    func transitionViewToScene(scene: SCNScene, transition:SKTransition) {
        NSNotificationCenter.defaultCenter().postNotificationName(kNotificationRemoveParentGestures, object: nil)
        print("Transitioning to scene: \(scene.classForCoder)")
        self.presentScene(scene, withTransition: transition, incomingPointOfView: nil) {
            NSNotificationCenter.defaultCenter().postNotificationName(kNotificationAddParentGestures, object: nil)
        }
    }
}
