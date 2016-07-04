//
//  Camera.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class Camera : Entity
{
    var type:CameraType?
    var camera:SCNCamera?
        {
        didSet
        {
            self.node.camera = self.camera!
        }
    }
}