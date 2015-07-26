//
//  AdventureDetailViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import UIKit

class AdventureDetailViewController: UIViewController, UITabBarDelegate {
    // MARK: tabBar outlets
    @IBOutlet var joinItem: UITabBarItem!
    @IBOutlet var editItem: UITabBarItem!
    @IBOutlet var deleteItem: UITabBarItem!
    @IBOutlet var bar: UITabBar!
 
    // MARK: info outlets
    @IBOutlet var map: UIImageView!
    
    // MARK: global vars
    var adventure: Adventure? // opened adventure
    var user: User? // current logged user
    
    lazy var adventureDetailsQueue: NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "Adventure details queue"
        queue.maxConcurrentOperationCount = 1
        return queue
        }()
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set adventure title
        self.title = "Details " + String(adventure!.id)
        
        // get current logged user
        user = currentUser()
        
        
        // MARK: tabBar init
        self.updateBarItems()
        
        // delegate bar
        self.bar.delegate = self
        
        // MARK: info init
        self.updateAdventureDetailInfo()
    }
    
    /// Updates bar item info
    /// Changes enabled to true or false and title to "Leave" or "Join" in joinItem
    func updateBarItems() {
        // enable buttons
        self.joinItem.enabled = adventure!.creator_id != user!.id
        // TODO: add in api 'adventure_edit' path
        self.editItem.enabled = false //adventure!.creator_id == user!.id
        self.deleteItem.enabled = adventure!.creator_id == user!.id
        
        // change title of join/leave item
        var hasJoined: Bool = false
        for participant in adventure!.participants {
            if (participant.id == user!.id) {
                hasJoined = true
                break
            }
        }
        self.joinItem.title = hasJoined ? "Leave" : "Join"
    }
    
    /// Updates adventure detail info
    func updateAdventureDetailInfo() {
        // TODO: write this func
        // updates adventure info (date/joined/participants)
        
        // update joined info text 
//        self.joinedLabel.text = self.adventure!.joined
        
        // update static map image
        self.map.image = self.adventure?.getStaticImage()
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        var request: NSMutableURLRequest? = nil
        
        if (item == joinItem) {
            var url: String = ""
            if (joinItem.title == "Join") {
                url = api_url + "/adventure/join" + "?user_id=" + String(user!.id) + "&adventure_id=" + String(adventure!.id)
            } else if (joinItem.title == "Leave") {
                url = api_url + "/adventure/leave" + "?user_id=" + String(user!.id) + "&adventure_id=" + String(adventure!.id)
            }
            request = NSMutableURLRequest()
            request!.URL = NSURL(string: url)
            request!.HTTPMethod = "GET"
        } else if (item == editItem) {
            var url: String = api_url + "/adventure/edit" + "?user_id=" + String(user!.id) + "&adventure_id=" + String(adventure!.id)
            request = NSMutableURLRequest()
            request!.URL = NSURL(string: url)
            request!.HTTPMethod = "GET"
        } else if (item == deleteItem) {
            var url: String = api_url + "/adventure/delete" + "?user_id=" + String(user!.id) + "&adventure_id=" + String(adventure!.id)
            request = NSMutableURLRequest()
            request!.URL = NSURL(string: url)
            request!.HTTPMethod = "GET"
        }
        
        if (request != nil) {
            NSURLConnection.sendAsynchronousRequest(request!, queue: self.adventureDetailsQueue, completionHandler: {(
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
                        let alert = UIAlertView(title: "Something Went Wrong", message: jsonResult["error"] as? String, delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    }
                    
                    return
                }
                
                // load adventures
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView(title: "Success", message: jsonResult["success"] as? String, delegate: nil, cancelButtonTitle: "OK")
                    alert.show()

                    // TODO: update adventures data
                    
                    // TODO: move this to adventure update function
                    
                    if (item == self.joinItem) {
                        if (self.joinItem.title == "Join") {
                            self.adventure!.participants.append((
                                id: self.user!.id as Int64,
                                username: self.user!.username as String
                            ))
                            self.adventure!.joined += 1
                        } else if (self.joinItem.title == "Leave") {
                            self.adventure!.participants = self.adventure!.participants.filter({
                                e in return e.id != self.user!.id
                            })
                            self.adventure!.joined -= 1
                        }
                    }
                    
                    // update adventure
                    let result: Bool = self.adventure!.update()
                    if (!result) {
                        // probably adventure does not exists
                    }
                    
                    // update (enabled and title)
                    self.updateBarItems()
                    
                    // update info (joined and participants)
                    self.updateAdventureDetailInfo()
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
