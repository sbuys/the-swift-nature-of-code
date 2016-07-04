//
//  SceneFactory.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class SceneFactory
{
    static func componentsForScene(sceneType:GameSceneType, completion:(SceneComponents->Void))
    {
        switch(sceneType)
        {
        case .Debug:
            SceneFactory.buildSceneComponents(SceneDebugComponents(), completion: completion)
        }
    }
    
    static func interactionsForScene(sceneType:GameSceneType,completion:(GameSceneGestureDelegate?->Void))
    {
        switch(sceneType)
        {
        case .Debug:
            SceneDebugComponents().sceneGestureDelegate(completion)
        }
    }
    
    static func buildSceneComponents(factory:SceneComponentFactory, completion:(SceneComponents->Void))
    {
        factory.componentsForScene({ (components) in
            completion(components)
        })
    }
}
