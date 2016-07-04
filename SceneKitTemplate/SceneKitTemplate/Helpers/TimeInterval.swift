//
//  TimeInterval.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation

extension NSTimeInterval
{
    static func randomIntervalBetween(minimum:Double, maximum:Double, speed:Double)->NSTimeInterval
    {
        return minimum + Double(arc4random_uniform( UInt32(maximum) )) / speed
    }
}
