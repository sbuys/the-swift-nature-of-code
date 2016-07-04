//
//  Geometry.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class Geometry: Entity, EntityModelControllerDelegate
{
    private var modelController:GeometryModelController = GeometryModelController()
    
    override init(){
        super.init()
        self.modelController.delegate = self
    }
    
    // MARK: EntityModelControllerDelegate
    
    func updateType(type:GeometryType){
        self.modelController.updateType(type)
    }
    
    func updateDiffuseColor(hexColor:String)
    {
        self.modelController.updateDiffuseColor(hexColor)
    }
    
    func updateAmbientColor(hexColor:String)
    {
        self.modelController.updateAmbientColor(hexColor)
    }
    
    func applyHexColorsMaterials(ambientHex:String, diffuseHex:String)
    {
        // TODO: Validate hex values
        self.modelController.updateAmbientColor(ambientHex)
        self.modelController.updateDiffuseColor(diffuseHex)
        self.applyDiffuseColor()
        self.applyAmbientColor()
    }
    
    func applyDiffuseColor()
    {
        self.node.geometry?.firstMaterial?.diffuse.contents = self.modelController.diffuseMaterial()
    }
    
    func applyAmbientColor()
    {
        self.node.geometry?.firstMaterial?.diffuse.contents = self.modelController.ambientMaterial()
    }
    
    func didUpdateType() {
        // Do nothing
    }
}