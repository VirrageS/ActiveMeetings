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
    
    lazy var registerQueue: NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "Register queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    @IBAction func checkRegister(sender: UIBarButtonItem) {
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text

        var url: String = api_url + "/user/register?username=" + username + "&email=" + email + "&password=" + password + "&confirm=" + password

        var request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        // send request to api
        NSURLConnection.sendAsynchronousRequest(request, queue: self.registerQueue, completionHandler: {(
            response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            var checkError = false
            if (jsonResult == nil) {
                print(data)
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView(title: "Error occured", message: String(stringInterpolationSegment: error), delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
                
                return
            }
            
            if (jsonResult["error"] != nil) {
                print(jsonResult["error"])
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView(title: "Something Is Wrong", message: jsonResult["error"] as? String, delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
                
                return
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertView(title: "Success", message: jsonResult["success"] as? String, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                
                // user created so back to home screen
                self.performSegueWithIdentifier("backToHomeScreen", sender: self)
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
