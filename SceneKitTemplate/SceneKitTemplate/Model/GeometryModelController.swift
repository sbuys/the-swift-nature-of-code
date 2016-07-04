//
//  GeometryModelController.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class GeometryModelController
{
    var model = GeometryModel()
    var delegate:EntityModelControllerDelegate?
    
    func updateType(type:GeometryType)
    {
        self.model.type = type
        if let d = self.delegate
        {
            d.didUpdateType()
        }
    }
    
    func updateDiffuseColor(hexColor:String)
    {
        self.model.diffuseColorHex = hexColor
    }
    
    func updateAmbientColor(hexColor:String)
    {
        self.model.ambientColorHex = hexColor
    }
    
    func diffuseMaterial()->UIColor
    {
        return self.model.diffuseColor
    }
    
    func ambientMaterial()->UIColor
    {
        return self.model.ambientColor
    }
}