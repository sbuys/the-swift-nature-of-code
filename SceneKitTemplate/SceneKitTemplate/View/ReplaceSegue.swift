//
//  ReplaceSegue.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import UIKit

@objc(ReplaceSegue)
class ReplaceSegue: UIStoryboardSegue {

    override func perform() {
        let source = self.sourceViewController as UIViewController
        let destination = self.destinationViewController as UIViewController
        let container = source.parentViewController
        
        container?.addChildViewController(destination)
        destination.view.frame = source.view.frame
        source.willMoveToParentViewController(nil)
        
        container?.transitionFromViewController(source, toViewController: destination, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            
            }, completion: { (finished:Bool) in
                if( finished )
                {
                    source.removeFromParentViewController()
                    destination.didMoveToParentViewController(container)
                }
        })
    }
    
}
