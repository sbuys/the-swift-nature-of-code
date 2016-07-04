//
//  ParentViewController.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit
import SceneKit

class ParentViewController: UIViewController {
    var childViewController:UIViewController?
    var parentSceneView:ParentSceneView?
    
    var customConstraints:[NSLayoutConstraint]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildSceneView()
        self.registerForNotifications()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func updateViewConstraints() {
        if self.customConstraints == nil
        {
            self.customConstraints = [NSLayoutConstraint]()
        }
        
        if self.customConstraints!.count > 0
        {
            self.view.removeConstraints(self.customConstraints!)
            self.customConstraints?.removeAll()
        }
        
        if self.parentSceneView != nil
        {
            if self.view.subviews.contains(self.parentSceneView!)
            {
                let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[parentSceneView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["parentSceneView":self.parentSceneView!])
                let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[parentSceneView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["parentSceneView":self.parentSceneView!])
                self.customConstraints?.appendContentsOf(horizontalConstraints)
                self.customConstraints?.appendContentsOf(verticalConstraints)
            }
        }
        
        self.view.addConstraints(self.customConstraints!)
        
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.insertSceneView()
    }
    
    func registerForNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNotificationRemoveParentGestures, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(removeAllGestureRecognizers), name: kNotificationRemoveParentGestures, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNotificationAddParentGestures, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(addSceneGestureRecognizers), name: kNotificationAddParentGestures, object: nil)
    }
    
    func buildSceneView(){
        self.parentSceneView = ParentSceneView(frame: CGRectZero, options: [SCNPreferredRenderingAPIKey:SCNRenderingAPI.Metal.rawValue])
        self.parentSceneView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func insertSceneView(){
        self.view.insertSubview(self.parentSceneView!, atIndex: 0)
        self.view.setNeedsUpdateConstraints()
        self.view.setNeedsLayout()
    }
    
    // MARK: Storyboards
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let name = segue.identifier
        {
            if name == SegueKey.EmbedChild.rawValue
            {
                self.childViewController = segue.destinationViewController
            }
        }
    }
    
    // MARK: Gestures
    
    func removeAllGestureRecognizers()
    {
        if self.view.gestureRecognizers != nil
        {
            for recognizer in self.view.gestureRecognizers!
            {
                self.view.removeGestureRecognizer(recognizer)
            }
        }
    }
    
    func addSceneGestureRecognizers()
    {
        if let s = self.parentSceneView!.scene as? GameScene
        {
            if let r = s.recognizers
            {
                for recognizer in r
                {
                    self.view.addGestureRecognizer(recognizer)
                }
            }
        }
    }
}
