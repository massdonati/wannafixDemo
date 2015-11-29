//
//  LoginViewController.swift
//  Wannafix
//
//  Created by massimo on 6/26/14.
//  Copyright (c) 2014 Team84. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var completionHandler: Void -> Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func connect(sender: UIButton) {
        UserModelManager.sharedManager.login(usernameTextField.text!, andPassword: passwordTextField.text!) { (user, error) -> Void in
            if (user != nil) {
                self.completionHandler()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Ooops", message: "Something went wrong" + error.localizedDescription , preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
