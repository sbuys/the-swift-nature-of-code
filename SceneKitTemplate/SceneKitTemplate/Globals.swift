//
//  Globals.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation

//MARK: Macros
/////////////////////////////////////////////////////////////

let DEBUG_FIREBASE_ACCOUNT =        true
let DEBUG_SCENEKIT_GAMESCENE =      false


// MARK: Keys
/////////////////////////////////////////////////////////////

enum StoryboardKey : String
{
    case ParentView =               "ParentView"
    case SignInView =               "SignInView"
}

enum SegueKey : String{
    case EmbedChild =               "EmbedChild"
    case ReplaceOnboarding =        "ReplaceOnboarding"
    case ReplaceSignIn =            "ReplaceSignIn"
    case UnwindReplaceSignIn =      "UnwindReplaceSignIn"
    case ReplaceSignUp =            "ReplaceSignUp"
    case UnwindReplaceSignUp =      "UnwindReplaceSignUp"
    case ReplaceGameHUD =           "ReplaceGameHUD"
}


// MARK: Position
/////////////////////////////////////////////////////////////

let kDebugCameraPosition:Vector3 = Vector3(x:0, y:0, z:10)


// MARK: Timing
/////////////////////////////////////////////////////////////

let kTransitionFadeParentInDuration:NSTimeInterval = 1.0


// MARK: Asset Names
/////////////////////////////////////////////////////////////

let kAssetEmptySkyboxPixelName =    "SkyboxPixel"
//let kAssetEmptySkyboxPixelName =    "SkyboxPixel_White"


// MARK: Notifications
/////////////////////////////////////////////////////////////

let kNotificationRemoveParentGestures = "kNotificationRemoveParentGestures"
let kNotificationAddParentGestures = "kNotificationAddParentGestures"