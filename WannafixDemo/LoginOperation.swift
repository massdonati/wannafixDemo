//
//  LoginOperation.swift
//  Wannafix
//
//  Created by massimo on 28/11/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit

class LoginOperation: Operation {

    lazy var storyboard: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }()
    
    lazy var loginViewController: LoginViewController = {
       let loginVC = self.storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        loginVC.completionHandler = {
            self.finish()
        }
        return loginVC
    }()
    
    
    lazy var presentationContext: UIViewController = {
        return UIApplication.sharedApplication().keyWindow!.rootViewController!
    }()
    
    override func execute() {
        guard UserModelManager.sharedManager.isUserLoggedIn() else {
            self.presentLoginController()
            return
        }
        self.finish()
    }
    
    func presentLoginController() {
        self.presentationContext.presentViewController(self.loginViewController, animated: true, completion: nil)
    }
    
}
