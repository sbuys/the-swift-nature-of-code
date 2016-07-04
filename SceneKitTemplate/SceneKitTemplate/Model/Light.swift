//
//  Light.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class Light: Entity
{
    var type:LightType?
    var light:SCNLight?
        {
        didSet
        {
            self.node.light = self.light!
        }
    }
}