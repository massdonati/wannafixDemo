//
//  UserModelController.swift
//  Wannafix
//
//  Created by massimo on 6/27/14.
//  Copyright (c) 2014 Team84. All rights reserved.
//

import Foundation

class UserModelManager {
    static let sharedManager = UserModelManager()
    
    required init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logout:", name: "logoutNotification", object: nil)
    }
    
    func logout() {
        PFUser.logOut()
    }
    
    func login(username :String, andPassword password :String,
        completionClosure closure:(user :PFUser!, error :NSError!) -> Void) {
            
            PFUser.logInWithUsernameInBackground(username, password: password, block:
                {
                    (user: PFUser?, error: NSError!)-> Void in
                    closure(user: user, error: error)
            })
            
    }
    
    func currentUser() -> PFUser? {
        return PFUser.currentUser()
    }
    
    
    func isUserLoggedIn() -> Bool {
        
        return PFUser.currentUser() != nil
    }
    
}
