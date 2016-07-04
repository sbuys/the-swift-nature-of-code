//
//  SceneDebugComponents.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import SpriteKit

// Geometry defaults
let kDebugBoxDimensions = Vector3(x:50.0, y:50.0, z:50.0)
let kDebugBoxChamferRadius:CGFloat = 0.03
let kDebugBoxNodeName = "DebugBox"


// Light defaults
let kSceneDebugLightAmbientColor:WhiteLightColorComponents = WhiteLightColorComponents(white: 0.4, alpha: 1.0)
let kSceneDebugLightAmbientVector:Vector3 = Vector3(x:-200.0, y:300.0, z:0.0)

let kSceneDebugLightFrontColor:WhiteLightColorComponents = WhiteLightColorComponents(white: 0.9, alpha: 1.0)
let kSceneDebugLightFrontVector:Vector3 = Vector3(x:-100.0, y:100.0, z:450.0)

// Camera defaults
let kSceneDebugCameraOptics:Vector3 = Vector3(x:20.0, y:20.0, z:1000.0)
let kSceneDebugCameraPosition:Vector3 = Vector3(x:0.0, y:0.0, z:350.0)

class SceneDebugComponents : SceneComponentFactory
{
    override func sceneCharacters(completion: ([Entity] -> Void)) {
        var retval = [Entity]()
        
        let box = GeometryFactory.geometryForType(.Box) { (shape) in
            return GeometryFactory.customizeBox(shape, size: kDebugBoxDimensions, chamferRadius: kDebugBoxChamferRadius)
        }
        box.node.name = kDebugBoxNodeName
        
        box.applyHexColorsMaterials("00FFFF", diffuseHex: "FF00FF")
        
        retval.append(box)
        
        completion(retval)
    }
    
    override func sceneLights(completion: ([Light] -> Void)) {
        var retval = [Light]()
        
        let color = UIColor(white: kSceneDebugLightAmbientColor.white, alpha: kSceneDebugLightAmbientColor.alpha)
        let position = SCNVector3(kSceneDebugLightAmbientVector.x, kSceneDebugLightAmbientVector.x, kSceneDebugLightAmbientVector.z)
        let light = LightFactory.lightForType(.Ambient) { (light) -> SCNNode in
            return LightFactory.customizeLight(light, color: color, position: position)
        }
        retval.append(light)
        
        // Omni light
        let lightFrontColor = UIColor(white:kSceneDebugLightFrontColor.white, alpha:kSceneDebugLightFrontColor.alpha)
        let lightFrontPosition = SCNVector3Make(kSceneDebugLightFrontVector.x, kSceneDebugLightFrontVector.x, kSceneDebugLightFrontVector.z)
        let lightFront = LightFactory.lightForType(.Omni) { (light) -> SCNNode in
            return LightFactory.customizeLight(light, color: lightFrontColor, position: lightFrontPosition)
        }
        retval.append(lightFront)

        
        completion(retval)
    }
    
    override func sceneCameras(completion: ([Camera] -> Void)) {
        var retval = [Camera]()
        
        let position = SCNVector3Make(kSceneDebugCameraPosition.x, kSceneDebugCameraPosition.y, kSceneDebugCameraPosition.z)
        let camera = CameraFactory.cameraForType(.Fixed) { (camera) -> SCNNode in
            return CameraFactory.customizeCamera(camera, xFov:nil, yFov: nil, zFar: kSceneDebugCameraOptics.z, position:position)
        }
        retval.append(camera)
        
        completion(retval)
    }
    
    // If the skybox returns nil, then the default skybox will be used
    override func sceneSkybox(completion: ([UIImage]? -> Void)) {
        completion(nil)
    }
    
    override func sceneGestureDelegate(completion: (GameSceneGestureDelegate? -> Void)) {
        completion(DebugInteractions())
    }
}


class DebugInteractions:GameSceneGestureDelegate
{
    var lastTranslation:CGPoint?
    
    override func recognizedGesture(gesture: UIGestureRecognizer) {
        if let g = gesture as? UIPanGestureRecognizer
        {
            if g.state == UIGestureRecognizerState.Began
            {
                self.lastTranslation = CGPointZero
            }
            else if g.state == .Changed
            {
                let rootView = UIApplication.sharedApplication().keyWindow?.rootViewController!.view
                
                let translationInView = g.translationInView(rootView)
                
                if let n = self.scene?.rootNode.childNodeWithName(kDebugBoxNodeName, recursively: false)
                {
                    let move = CGPointMake(translationInView.x - self.lastTranslation!.x, translationInView.y - self.lastTranslation!.y)
                    print(move)
                    n.position = SCNVector3(n.position.x + Float(move.x), n.position.y - Float(move.y), 0.0)
                }
                
                self.lastTranslation = translationInView
            }
        }
    }
}

