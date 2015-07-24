//
//  RegisterViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func checkRegister(sender: UIBarButtonItem) {
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = emailTextField.text
        
        // check username
        if (username == nil || username == "") {
            let alert = UIAlertView(title: "Invalid Username", message: "Username field is required", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            return
        } else if (username == "tomek") {
            
        }
        
        // send request to api
        
        if (email == "hello") {
            // email or password is not correct
            let alert = UIAlertView(title: "No Account Found", message: "No account found for this email. Have you signed up?", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            // user has logged in
            let user = User(id: 1, username: "Tomek", email: "tomek@tomek.com", password: "adfs")
            user.login()
            
            // user has been logged so we can open all adventures controller
            self.performSegueWithIdentifier("openAdventuresFromLogin", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
