//
//  MotionLibrary.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

// Aiko character movement animations
enum MotionType{
    case FloatInPlace
}

class MotionLibrary{
    
}

// MARK: Actions
extension MotionLibrary
{
    static func moveInDirection(direction:SCNVector3, duration:NSTimeInterval)->SCNAction
    {
        return SCNAction.moveByX(CGFloat(direction.x), y: CGFloat(direction.y), z: CGFloat(direction.z), duration:duration)
    }
}

// MARK: Motions
extension MotionLibrary
{
    static func loopedActionWithParameters(parameters:[ActionParamsMove])->SCNAction
    {
        var sequence = [SCNAction]()
        for (index, p) in parameters.enumerate()
        {
            var duration = p.durationMinimum
            if p.durationMaximum != p.durationMaximum
            {
                duration = NSTimeInterval.randomIntervalBetween(p.durationMinimum, maximum: p.durationMaximum, speed: p.speed)
            }
            
            sequence.append(MotionLibrary.moveInDirection(p.vector, duration: duration))
        }
        
        return SCNAction.repeatActionForever(SCNAction.sequence(sequence))
    }
    
    // TODO: Define motion actions
}