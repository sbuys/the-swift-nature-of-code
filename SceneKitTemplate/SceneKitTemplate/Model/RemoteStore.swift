//
//  RemoteStore.swift
//  SceneKitTemplate
//
//  Created by Voxels on 7/3/16.
//  Copyright © 2016 Noise Derived. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit

class RemoteStore
{
    let ref = FIRDatabase.database().reference()
    
    static let sharedStore = RemoteStore()
    
    private init(){
        
    }
    
    func warmUp(){
        if DEBUG_FIREBASE_ACCOUNT
        {
            if self.currentUser() != nil
            {
                self.signOutCurrentUser({ () in
                    print("Signed out current user")
                    }, failure: { (description:String?) in
                        print("Failed to sign out current user")
                })
            }
        }
    }
    
    func currentUser()->FIRUser?
    {
        return FIRAuth.auth()?.currentUser
    }
    
    // MARK: Authentication
    
    func userSignedInEmail(email:String, password:String, success:(FIRUser?->Void), failure:(String?->Void))
    {
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            if let e = error
            {
                self.handleAuthError(e, completion: failure)
                return
            }
            
            if let u = user
            {
                success(u)
            }
            else
            {
                failure(nil)
            }
        }
    }
    
    func userSignedInAnonymously(success:(FIRUser?->Void), failure:(String?->Void))
    {
        FIRAuth.auth()?.signInAnonymouslyWithCompletion(){(user, error) in
            if let e = error
            {
                self.handleAuthError(e, completion: failure)
                return
            }
            
            if let u = user{
                success(u)
            }
        }
    }
    
    func resetPassword(email:String, success:(Void->Void), failure:(String?->Void))
    {
        FIRAuth.auth()?.sendPasswordResetWithEmail(email, completion: { (error:NSError?) in
            if let e = error
            {
                self.handleAuthError(e, completion: failure)
                return
            }
            success()
        })
    }
    
    func userLinkWithEmail(success:(FIRUser?->Void), failure:(String?->Void))
    {
        /*
         let credential = FIREmailPasswordAuthProvider.credentialWithEmail(email, password: password)
         
         FIRAuth.auth()?.currentUser.linkWithCredential(credential) { (user, error) in
         if let e = error
         {
         print("Error: Linking with Email: \(e.localizedDescription)")
         failure()
         return
         }
         
         if let u = user{
         success(u)
         }
         }
         */
    }
    
    // Must sign in with the Facebook Login button before calling this function
    func userLinkWithFacebook(success:(FIRUser?->Void), failure:(String?->Void))
    {
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        
        if let u = FIRAuth.auth()?.currentUser
        {
            u.linkWithCredential(credential) { (user, error) in
                if let e = error
                {
                    self.handleAuthError(e, completion: failure)
                    return
                }
                
                if let u = user{
                    success(u)
                }
            }
        }
        else
        {
            failure(nil)
        }
    }
    
    func signOutCurrentUser(success:(Void->Void), failure:(String?->Void))
    {
        do{
            try FIRAuth.auth()?.signOut()
            success()
        }
        catch let error as NSError{
            self.handleAuthError(error, completion: failure)
        }
    }
    
    // MARK: Fetch
    
    // MARK: Error Handling
    
    func handleAuthError(error:NSError, completion:(String->Void))
    {
        if let errorCode = FIRAuthErrorCode(rawValue: error.code)
        {
            switch errorCode
            {
            case .ErrorCodeInvalidUserToken:
                self.handleInvalidUserTokenError(error, completion: completion)
            case .ErrorCodeInvalidEmail:
                self.handleInvalidEmailError(error, completion: completion)
            case .ErrorCodeUserDisabled:
                self.handleUserDisabledError(error, completion: completion)
            case .ErrorCodeWrongPassword:
                self.handleWrongPasswordError(error, completion: completion)
            case .ErrorCodeEmailAlreadyInUse:
                self.handleEmailAlreadyInUseError(error, completion: completion)
            case .ErrorCodeWeakPassword:
                self.handleWeakPasswordError(error, completion: completion)
            case .ErrorCodeProviderAlreadyLinked:
                self.handleProviderAlreadyLinkedError(error, completion: completion)
            case .ErrorCodeCredentialAlreadyInUse:
                self.handleCredentialAlreadyInUseError(error, completion: completion)
            case .ErrorCodeNoSuchProvider:
                self.handleNoSuchProviderError(error, completion: completion)
            default:
                self.handleError(error, completion: completion)
            }
        }
    }
    
    func handleError(error:NSError, completion:(String->Void))
    {
        if let errorCode = FIRAuthErrorCode(rawValue: error.code)
        {
            switch errorCode
            {
            case .ErrorCodeNetworkError:
                self.handleNetworkError(error, completion: completion)
            case .ErrorCodeUserNotFound:
                self.handleUserNotFoundError(error, completion: completion)
            case .ErrorCodeUserTokenExpired:
                self.handleUserTokenExpiredError(error, completion: completion)
            case .ErrorCodeTooManyRequests:
                self.handleTooManyRequestsError(error, completion: completion)
            case .ErrorCodeInvalidAPIKey:
                self.handleInvalidAPIKeyError(error, completion: completion)
            case .ErrorCodeAppNotAuthorized:
                self.handleAppNotAuthorizedError(error, completion: completion)
            case .ErrorCodeKeychainError:
                self.handleKeychainError(error, completion: completion)
            case .ErrorCodeInternalError:
                self.handleInternalError(error, completion: completion)
            default:
                self.handleUnknownError(error, completion: completion)
            }
        }
    }
    
    // TODO: Actually handle these errors with messaging instead of server responses
    // Error code documentation:
    // https://firebase.google.com/docs/auth/ios/errors#error_codes_common_to_all_api_methods
    
    func handleInvalidUserTokenError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase INVALID TOKEN error")
        completion(error.localizedDescription)
    }
    
    func handleInvalidEmailError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase INVALID EMAIL error")
        completion(error.localizedDescription)
    }
    
    func handleUserDisabledError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase USER DIABLED error")
        completion(error.localizedDescription)
    }
    
    func handleWrongPasswordError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase WRONG PASSWORD error")
        completion(error.localizedDescription)
    }
    
    func handleEmailAlreadyInUseError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase EMAIL ALREADY IN USE error")
        completion(error.localizedDescription)
    }
    
    func handleWeakPasswordError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase WEAK PASSWORD error")
        completion(error.localizedDescription)
    }
    
    func handleRequiresRecentLoginError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase REQUIRES RECENT LOGIN error")
        completion(error.localizedDescription)
    }
    
    func handleProviderAlreadyLinkedError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase PROVIDER ALREADY LINKED error")
        completion(error.localizedDescription)
    }
    
    func handleCredentialAlreadyInUseError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase CREDENTIAL ALREADY IN USE error")
        completion(error.localizedDescription)
    }
    
    func handleKeychainError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase KEYCHAIN error")
        completion(error.localizedDescription)
    }
    
    func handleNoSuchProviderError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase NO SUCH PROVIDER error")
        completion(error.localizedDescription)
    }
    
    func handleNetworkError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase NETWORK error")
        completion(error.localizedDescription)
    }
    
    func handleUserNotFoundError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase NOT FOUND error")
        completion(error.localizedDescription)
    }
    
    func handleUserTokenExpiredError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase TOKEN EXPIRED error")
        completion(error.localizedDescription)
    }
    
    func handleTooManyRequestsError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase TOO MANY REQUESTS error")
        completion(error.localizedDescription)
    }
    
    func handleInvalidAPIKeyError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase INVALID API error")
        completion(error.localizedDescription)
    }
    
    func handleAppNotAuthorizedError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase APP NOT AUTHORIZED error")
        completion(error.localizedDescription)
    }
    
    func handleInternalError(error:NSError, completion:(String->Void))
    {
        print("Error: Received Firebase INTERNAL error")
        completion(error.localizedDescription)
    }
    
    func handleUnknownError(error:NSError, completion:(String->Void))
    {
        print("Error: Failed to log in with UNKNOWN error \(error)")
        completion(error.localizedDescription)
    }
    
    
}