//
//  GameScene.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class GameSceneGestureDelegate
{
    var scene:GameScene?
    func recognizedGesture(gesture:UIGestureRecognizer){}
}

enum GameSceneType{
    case Debug
}

struct SceneComponents
{
    var characters:[Entity]?
    var lights:[Light]?
    var cameras:[Camera]?
    var skybox:[UIImage]?
}

class GameScene: SCNScene {

    var components:SceneComponents?
    
    var type:GameSceneType?
    
    var gestureDelegate:GameSceneGestureDelegate?
    var recognizers:[UIGestureRecognizer]?
    
    convenience init(type:GameSceneType)
    {
        self.init()
        self.type = type
        self.buildScene()
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildScene(){
        self.rootNode.name = "root"
        
        self.prepareScene { () in
            self.placeSkybox()
            self.placeCameras()
            self.placeLights()
            self.placeCharacters()
            self.addGestures()
            self.addGestureDelegate()
        }
    }
    
    private func addGestures()
    {
        self.recognizers = [UIGestureRecognizer]()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onRecognizeGesture))
        
        self.recognizers?.append(panGesture)
    }
    
    func addGestureDelegate()
    {
        if let t = self.type
        {
            SceneFactory.interactionsForScene(t) { (delegate) in
                if let d = delegate
                {
                    self.gestureDelegate = d
                    self.gestureDelegate?.scene = self
                }
            }
        }
    }
    
    private func prepareScene(completion:(Void->Void)){
        if let t = self.type
        {
            SceneFactory.componentsForScene(t) { (components:SceneComponents) in
                self.components = components
                completion()
            }
        }
    }
    
    func placeSkybox()
    {
        if self.components?.skybox == nil
        {
            let emptySkyboxPixelImage:UIImage = UIImage(named: kAssetEmptySkyboxPixelName)!
            
            self.background.contents = [emptySkyboxPixelImage,
                                        emptySkyboxPixelImage,
                                        emptySkyboxPixelImage,
                                        emptySkyboxPixelImage,
                                        emptySkyboxPixelImage,
                                        emptySkyboxPixelImage]
        }
        else
        {
            assert( self.components?.skybox?.count == 6)
            self.background.contents = self.components?.skybox
        }
    }
    
    func placeCameras()
    {
        if let cameras = self.components?.cameras
        {
            for camera in cameras
            {
                self.rootNode.addChildNode(camera.node)
            }
        }
        else
        {
            // TODO: Create default camera
        }
    }
    
    func placeLights(){
        if let lights = self.components?.lights
        {
            for light in lights
            {
                self.rootNode.addChildNode(light.node)
            }
        }
        else
        {
            // TODO: Create default lights
        }
    }
    
    func placeCharacters(){
        if let characters = self.components?.characters
        {
            for character in characters
            {
                self.rootNode.addChildNode(character.node)
            }
        }
    }
    
    // UIGestureRecognizer
    
    func onRecognizeGesture(sender:UIGestureRecognizer)
    {
        if let g = self.gestureDelegate
        {
            g.recognizedGesture(sender)
        }
    }
    
}
