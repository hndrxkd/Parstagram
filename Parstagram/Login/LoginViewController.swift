//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Kevin Denis on 11/15/19.
//  Copyright © 2019 Kevin Denis. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (User, Error) in
            if(User != nil) {
             self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
             print("Error: \(Error?.localizedDescription as Optional)")
        }
    }
}

}
