//
//  GeometryModel.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit
import ColorUtils

class GeometryModel
{
    var type:GeometryType?
    var geometry:SCNGeometry?
    var action:SCNAction?
    var diffuseColorHex:String?
    var ambientColorHex:String?
    
    var diffuseColor:UIColor
    {
        get{
            return UIColor(string: self.diffuseColorHex)
        }
    }
    
    var ambientColor:UIColor
        {
        get{
            return UIColor(string: self.ambientColorHex)
        }
    }

}