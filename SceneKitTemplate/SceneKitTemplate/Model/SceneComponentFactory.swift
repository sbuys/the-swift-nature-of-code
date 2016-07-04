//
//  SceneComponentFactory.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import SpriteKit

// Template class for overriding per scene to define scene components
class SceneComponentFactory
{
    func componentsForScene(completion:SceneComponents->Void)
    {
        self.sceneCharacters { (characters:[Entity]) in
            self.sceneLights({ (lights:[Light]) in
                self.sceneCameras({ (cameras:[Camera]) in
                    self.sceneSkybox({ (skybox:[UIImage]?) in
                        completion(SceneComponents(characters: characters, lights: lights, cameras: cameras, skybox: skybox))
                    })
                })
            })
        }
    }
    
    func sceneCharacters(completion:([Entity]->Void)){}
    func sceneLights(completion:([Light]->Void)){}
    func sceneCameras(completion:([Camera]->Void)){}
    func sceneSkybox(completion:([UIImage]?->Void)){}  // If skybox is nil, use default
    func sceneGestureDelegate(completion:(GameSceneGestureDelegate?->Void)){}
}