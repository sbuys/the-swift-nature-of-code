//
//  Entity.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

// Empty abstract protocol for all entities to ensure type safety in Characters
class Entity {
    var node:SCNNode = SCNNode()
}

protocol EntityModelControllerDelegate
{
    func didUpdateType()
}
