//
//  SceneController.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

protocol SceneControllerViewDelegate
{
    func transitionViewToScene(scene: SCNScene, transition:SKTransition)
}

/////////////////////////////////////////////////////////////

class SceneController
{
    static let sharedInstance = SceneController()
    var delegate:SceneControllerViewDelegate?
    
    private init() {
    }
    
    func userIsAuthenticated()->Bool
    {
        return User.hasAuthenticated()
    }
    
    func showSceneWithTransition(scene:GameScene, transition:SKTransition)
    {
        if let d = self.delegate
        {
            d.transitionViewToScene(scene, transition:transition)
        }
    }
}
