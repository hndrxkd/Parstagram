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
            if(User != nil){
             self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
             print("Error: \(Error?.localizedDescription)")
        }
    }
}
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
              user.username = usernameField.text
              user.password = passwordField.text
        
              user.signUpInBackground { (success, Error) in
                  if(success){
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                  }else{
                      print("Error: \(Error?.localizedDescription)")
                  }
              }
              
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
