//
//  Dispatch.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation

class Dispatch{
    static func scheduleBlockOnMainQueueWithDelay(delayInSeconds:Double, block:Void->Void)
    {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            block()
        }
    }
}