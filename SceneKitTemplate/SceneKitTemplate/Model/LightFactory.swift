//
//  LightFactory.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

enum LightType : String
{
    case Omni = "EntityLightOmni"
    case Ambient = "EntityLightAmbient"
    case Directional = "EntityLightDirectional"
    case Spot = "EnittyLightSpot"
}

class LightFactory
{
    static func lightForType(lightType:LightType, customize:(SCNNode->SCNNode)?)->Light
    {
        let retval = Light()
        retval.type = lightType
        
        let light = self.lightForType(lightType)
        retval.light = light
        
        if customize != nil
        {
            retval.node = customize!(retval.node)
        }
        else
        {
            
        }
        
        return retval
    }
    
    static func lightForType(lightType:LightType)->SCNLight
    {
        let retval = SCNLight()
        switch(lightType)
        {
        case .Omni:
            retval.type = SCNLightTypeOmni
        case .Ambient:
            retval.type = SCNLightTypeAmbient
        case .Directional:
            retval.type = SCNLightTypeDirectional
        case .Spot:
            retval.type = SCNLightTypeSpot
        }
        return retval
    }
    
    static func customizeLight(lightNode:SCNNode, color:UIColor, position:SCNVector3)->SCNNode
    {
        let retval = SCNNode()
        if let l = lightNode.light
        {
            retval.light = l
        }
        else
        {
            retval.light = LightFactory.lightForType(.Ambient)
        }
        retval.light!.color = color
        retval.position = position
        return retval
    }
}