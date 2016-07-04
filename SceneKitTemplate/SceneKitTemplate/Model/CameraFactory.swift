//
//  CameraFactory.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

// Camera positions and actions
enum CameraType{
    case Fixed
}

class CameraFactory
{
    static func cameraForType(type:CameraType, customize:(SCNNode->SCNNode)?)->Camera
    {
        let retval = Camera()
        retval.type = type
        
        if customize != nil
        {
            retval.node = customize!(retval.node)
        }
        else
        {
            retval.camera = SCNCamera()
        }
        
        return retval
    }
    
    static func customizeCamera(cameraNode:SCNNode, xFov:Float?, yFov: Float?, zFar:Float?, position:SCNVector3 )->SCNNode
    {
        let retval = SCNNode()
        
        if let c = cameraNode.camera
        {
            retval.camera = c
        }
        else
        {
            retval.camera = SCNCamera()
        }
        
        if let x = xFov
        {
            retval.camera?.xFov = Double(x)
        }
        
        if let y = yFov
        {
            retval.camera?.yFov = Double(y)
        }
        
        if let z = zFar
        {
            retval.camera?.zFar = Double(z)
        }
        
        retval.position = position
        
        return retval
    }
    
    func placeFixedCameraAtPoint(vector:Vector3)
    {
        /*
         let cameraNode = SCNNode()
         cameraNode.name = "Camera"
         cameraNode.camera = SCNCamera()
         cameraNode.camera?.xFov = 20.0
         cameraNode.camera?.yFov = 20.0
         cameraNode.camera?.zFar = 10000.0
         self.rootNode.addChildNode(cameraNode)
         cameraNode.position = SCNVector3Make(vector.x, vector.y, vector.z);
         */
    }
}
