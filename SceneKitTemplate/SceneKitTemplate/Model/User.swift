//
//  User.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import Firebase

class User{
    
    static func signInEmail(email:String, password:String, success:(Void->Void), failure:(String?->Void))
    {
        RemoteStore.sharedStore.userSignedInEmail(email, password: password, success: { (user:FIRUser?) in
            if user != nil
            {
                success()
            }
            else
            {
                assert(true, "Sign in email: should not reach this point")
                failure(nil)
            }
            }, failure: failure)
    }
    
    static func signInFacebook(success:(Void->Void), failure:(String?->Void))
    {
        
        
    }
    
    static func signInAnonymously(success:(Void->Void), failure:(String?->Void))
    {
        RemoteStore.sharedStore.userSignedInAnonymously({ (u:FIRUser?) in
            if( u != nil )
            {
                success()
            }
            else
            {
                assert(true, "Sign in anonymously: should not reach this point")
                failure(nil)
            }
        }) { (description:String?) in
            failure(description)
        }
    }
    
    static func hasAuthenticated()->Bool
    {
        var retval:Bool = false
        retval = RemoteStore.sharedStore.currentUser() != nil
        return retval
    }
    
    static func logout(success:(Void->Void), failure:(String?->Void))
    {
        RemoteStore.sharedStore.signOutCurrentUser(success, failure: failure)
    }
    
    static func resetPassword(email:String, success:(Void->Void), failure:(String?->Void))
    {
        RemoteStore.sharedStore.resetPassword(email, success: success, failure: failure)
    }
}