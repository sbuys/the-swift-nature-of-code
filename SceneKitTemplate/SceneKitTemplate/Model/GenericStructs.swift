//
//  GenericStructs.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import SpriteKit

struct Vector3
{
    var x:Float = 0.0
    var y:Float = 0.0
    var z:Float = 0.0
}

struct Vector4
{
    var x:Float = 0.0
    var y:Float = 0.0
    var z:Float = 0.0
    var w:Float = 0.0
}

struct WhiteLightColorComponents
{
    var white:CGFloat = 0.0
    var alpha:CGFloat = 0.0
}

struct LightColorComponents
{
    var red:CGFloat = 0.0
    var green:CGFloat = 0.0
    var blue:CGFloat = 0.0
    var alpha:CGFloat = 0.0
}

struct ActionParamsMove{
    var durationMinimum:Double
    var durationMaximum:Double
    var vector:SCNVector3
    var speed:Double
}
