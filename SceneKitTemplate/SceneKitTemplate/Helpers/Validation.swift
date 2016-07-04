//
//  Validation.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation

class Validation{
    
    // Email Regex from: http://emailregex.com
    static func validateEmailAddress(candidate:String)->Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
    }
    
    //TODO: Worst possible password validation.  Needs real rules.
    static func validatePassword(candidate:String)->Bool
    {
        var retval = false
        if candidate.characters.count > 0
        {
            retval = true
        }
        return retval
    }
}