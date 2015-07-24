//
//  LoginViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import Foundation

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func checkLogin(sender: UIBarButtonItem) {
        let email = emailTextField.text
        let password = emailTextField.text
        
        if (email == "hello") {
            // email or password is not correct
            let alert = UIAlertView(title: "No Account Found", message: "No account found for this email. Have you signed up?", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            // user has logged in
//            let user = User()
//            user.login()
            
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
