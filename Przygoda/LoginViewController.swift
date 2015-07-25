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
    
    var user: User?
    
    
    lazy var loginQueue: NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "Login queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    @IBAction func checkLogin(sender: UIBarButtonItem) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        
        var url: String = api_url + "/user/login?email=" + email + "&password=" + password
        var request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: self.loginQueue, completionHandler: {(
            response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            var checkError = false
            if (jsonResult == nil) {
                print(error)
                
                // display alert with error
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView(title: "Error occured", message: String(stringInterpolationSegment: error), delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }

                return
            }
            
            if (jsonResult["error"] != nil) {
                print(jsonResult["error"])
                
                // display error
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView(title: "No Account Found", message: "No account found for this email. Have you signed up?", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
                
                return
            }

            // load user
            let user = jsonResult
            
            var id: Int64 = user["id"]!.longLongValue as Int64
            var social_id: String = user["social_id"] as! String
            var username: String = user["username"] as! String
            var email: String = user["email"] as! String
            var registered_on: Int64 = user["registered_on"]!.longLongValue as Int64
            
            let u = User(id: id, social_id: social_id, username: username, email: email, registered_on: registered_on)

            dispatch_async(dispatch_get_main_queue()) {
                // TODO: change user login
                loginUser(u)
                self.performSegueWithIdentifier("openAdventuresFromLogin", sender: self)
            }
        })
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
