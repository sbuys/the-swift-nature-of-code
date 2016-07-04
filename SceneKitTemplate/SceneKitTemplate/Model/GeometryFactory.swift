//
//  GeometryFactory.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

enum GeometryType : String
{
    case Box = "EntityGeometryBox"
    case Sphere = "EntityGeometrySphere"
}

class GeometryFactory
{
    static func geometryForType(type:GeometryType, customize:(SCNGeometry->SCNGeometry?)?)->Geometry
    {
        let retval = Geometry()
        let shape = self.shapeForType(type)
        retval.updateType(type)
        
        if customize != nil
        {
            retval.node.geometry = customize!(shape)
        }
        else
        {
            retval.node.geometry = shape
        }
        return retval
    }
    
    static func shapeForType(type:GeometryType)->SCNGeometry
    {
        switch(type)
        {
        case .Box:
            return self.boxGeometry()
        case .Sphere:
            return self.sphereGeometry()
        }
    }
    
    static func boxGeometry()->SCNBox
    {
        return SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
    }
    
    static func sphereGeometry()->SCNSphere
    {
        return SCNSphere(radius:1)
    }
    
    static func customizeBox(shape:SCNGeometry, size:Vector3, chamferRadius:CGFloat)->SCNGeometry?
    {
        if let b = shape as? SCNBox
        {
            b.width = CGFloat(size.x)
            b.height = CGFloat(size.y)
            b.length = CGFloat(size.z)
            
            b.chamferRadius = chamferRadius
            return b
        }
        return nil
    }
}

