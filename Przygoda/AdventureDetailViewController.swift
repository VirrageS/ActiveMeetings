//
//  AdventureDetailViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import UIKit

class AdventureDetailViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    
    
    // MARK: - Tab bar outlets
    @IBOutlet var joinItem: UITabBarItem!
    @IBOutlet var editItem: UITabBarItem!
    @IBOutlet var deleteItem: UITabBarItem!
    @IBOutlet var bar: UITabBar!
 
    // MARK: - Detail info outlets
    @IBOutlet var map: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var creatorUsernameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var joinedLabel: UILabel!
    
    @IBOutlet var participantsTableView: UITableView!
    
    // MARK: - Global vars
    var adventure: Adventure? // opened adventure
    var user: User? // current logged user
    
    lazy var adventureDetailsQueue: NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "Adventure details queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    // refresher
    var refreshControl: UIRefreshControl!
    
    // MARK: - Main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update info
        self.title = "Details " + String(adventure!.id) // set adventure title
        self.user = currentUser() // get current logged user
        self.updateAdventureDetailInfo() // update detail info

        // delegate scrollView
        self.scrollView.delegate = self
        // delegate tableView
        self.participantsTableView.delegate = self
        self.participantsTableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refreshInfo:", forControlEvents: UIControlEvents.ValueChanged)
        self.scrollView.addSubview(refreshControl)
        
        // delegate bar
        self.bar.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateContentSize()
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        var url: String? = nil
        
        switch(item) {
        case joinItem:
            if (joinItem.title == "Join") {
                url = api_url + "/adventure/join" + "?user_id=" + String(user!.id) + "&adventure_id=" + String(adventure!.id)
            } else if (joinItem.title == "Leave") {
                url = api_url + "/adventure/leave" + "?user_id=" + String(user!.id) + "&adventure_id=" + String(adventure!.id)
            }
        case editItem:
            url = api_url + "/adventure/edit" + "?user_id=" + String(user!.id) + "&adventure_id=" + String(adventure!.id)
        case deleteItem:
            url = api_url + "/adventure/delete" + "?user_id=" + String(user!.id) + "&adventure_id=" + String(adventure!.id)
        default:
            url = nil
        }

        if (url != nil) {
            var request: NSMutableURLRequest = NSMutableURLRequest()
            request = NSMutableURLRequest()
            request.URL = NSURL(string: url!)
            request.HTTPMethod = "GET"
            
            // autorization
            //        let PasswordString = "\(txtUserName.text):\(txtPassword.text)"
            //        let PasswordData = PasswordString.dataUsingEncoding(NSUTF8StringEncoding)
            //        let base64EncodedCredential = PasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            //        request.setValue("Basic \(base64EncodedCredential)", forHTTPHeaderField: "Authorization")
            
            NSURLConnection.sendAsynchronousRequest(request, queue: self.adventureDetailsQueue, completionHandler: {(
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
                        // FIXME: write this statement
                    }
                    
                    // update info (joined and participants)
                    self.updateAdventureDetailInfo()
                }
            })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.adventure!.participants.count
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Participants"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let participantCell = tableView.dequeueReusableCellWithIdentifier("ParticipantCell", forIndexPath: indexPath) as! AdventureDetailTableViewCell
        participantCell.participantUsernameLabel.text = self.adventure!.participants[indexPath.row].username
        return participantCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom functions
    func updateContentSize() {
        dispatch_async(dispatch_get_main_queue()) {
            self.participantsTableView.frame.size.height = self.participantsTableView.contentSize.height
            self.scrollView.contentSize = CGSizeMake(
                self.view.frame.width,
                self.participantsTableView.frame.maxY
            )
            
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        }
    }
    
    
    /**
        Updates bar item info.
        Changes enabled to true or false and title to "Leave" or "Join" in joinItem
    */
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
    
    /**
        Refreshes info
    */
    func refreshInfo(sender: AnyObject) {
        var url: String = api_url + "/adventure/get/" + String(self.adventure!.id)
        var request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: self.adventureDetailsQueue, completionHandler: {(
            response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult == nil) {
                // display alert with error
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView(title: "Error occured", message: "Internal error. Please try again", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    
                    // stop refreshing
                    if (self.refreshControl.refreshing) {
                        self.refreshControl.endRefreshing()
                    }
                }
                
                return
            }
            
            // load adventures
            dispatch_async(dispatch_get_main_queue()) {
                let adventureData = jsonResult
                self.adventure?.date = adventureData["date"] as! Int
                self.adventure?.info = adventureData["info"] as! String
                self.adventure?.joined = adventureData["joined"] as! Int
                var participants: [(id: Int64, username: String)] = []
                for (_, participantData) in adventureData["participants"] as! NSDictionary {
                    participants.append((
                        id: participantData["id"]!!.longLongValue as Int64,
                        username: participantData["username"] as! String
                    ))
                }
                self.adventure?.participants = participants
                self.adventure?.image_url = adventureData["static_image_url"] as! String
                
                
                // update info
                self.updateAdventureDetailInfo()
                
                // stop refreshing
                if (self.refreshControl.refreshing) {
                    self.refreshControl.endRefreshing()
                }
            }
        })
    }
    
    /**
        Updates adventure detail info.
    */
    func updateAdventureDetailInfo() {
        // TODO: write this func
        // updates adventure info (date/joined/participants)
        
        // update joined info text
        //        self.joinedLabel.text = self.adventure!.joined
        
        // update static map image
        self.map.image = self.adventure?.getStaticImage()
        self.infoLabel.text = self.adventure?.info
        self.creatorUsernameLabel.text = self.adventure?.creator_username
        self.dateLabel.text = self.adventure?.getFormattedDate()
        self.joinedLabel.text = String(self.adventure!.joined)
        
        self.updateBarItems()
        
        self.participantsTableView.reloadData()
        self.updateContentSize()
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
