//
//  SignUpViewController.swift
//  Parstagram
//
//  Created by Kevin Denis on 11/20/19.
//  Copyright © 2019 Kevin Denis. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var UsernameField: UITextField!
    
    func makeRounded(){
        ProfileImage.layer.masksToBounds = false
        ProfileImage.layer.cornerRadius = ProfileImage.frame.height/2
        ProfileImage.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRounded()
        
    }
    
    //create a set user profile picture method ?
    
    @IBAction func onCreateAccount(_ sender: Any) {
        let user = PFUser()
        user.username = UsernameField.text
        user.password = PasswordField.text
        user.email = EmailField.text
        
        user.signUpInBackground { (success, Error) in
           if(success) {
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
            } else {
            print("Error: \(Error?.localizedDescription as Optional)")
            }
        }
    }
}
