//
//  RootNavigationController.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class RootNavigationController: UINavigationController, UINavigationControllerDelegate {
    let sceneControl:SceneController = SceneController.sharedInstance
    var rootViewController:ParentViewController?
    var didPresentParentView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    
    // MARK: State
    // TODO: Handle no internet
    
    func checkLandingState()
    {
        if DEBUG_SCENEKIT_GAMESCENE
        {
            let scene = GameScene(type:.Debug)
            self.showGameScene(scene, transition:SKTransition.fadeWithDuration(kTransitionFadeParentInDuration))
        }
        else
        {
            if self.sceneControl.userIsAuthenticated()
            {
                
                
            }
            else
            {
                // TODO: Insert GamePlayKit Scene control
                if self.rootViewController?.childViewController?.childViewControllers.count == 0
                {
                    let scene = GameScene(type: .Debug )
                    self.showGameScene(scene, transition:SKTransition.fadeWithDuration(kTransitionFadeParentInDuration))
                }
            }
        }
    }
    
    // MARK: Init
    
    func didFinishLaunchingWithOptions(launchOptions: [NSObject: AnyObject]?)
    {
        self.showParentView()
    }
    
    
    // MARK: Views
    
    func showParentView()
    {
        if let root = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardKey.ParentView.rawValue) as? ParentViewController
        {
            self.rootViewController = root
            if let sceneView = self.rootViewController?.parentSceneView
            {
                SceneController.sharedInstance.delegate = sceneView
            }
            
            self.setViewControllers([self.rootViewController!], animated: false)
        }
    }
    
    func showGameScene(scene:GameScene, transition:SKTransition)
    {
        if let child = self.rootViewController?.childViewController
        {
            child.performSegueWithIdentifier(SegueKey.ReplaceGameHUD.rawValue, sender: self)
            User.signInAnonymously({ () in
                SceneController.sharedInstance.showSceneWithTransition(scene, transition: transition)
                }, failure: { (description:String?) in
                    if let d = description
                    {
                        print(d)
                    }
            })
        }
        else{
            fatalError("No Child view controller found")
        }
    }
    
    
    // MARK: UINavigationControllerDelegate
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        
        if viewController.classForCoder == ParentViewController.classForCoder() && self.didPresentParentView == false
        {
            self.didPresentParentView = true
            self.checkLandingState()
        }
    }
}
