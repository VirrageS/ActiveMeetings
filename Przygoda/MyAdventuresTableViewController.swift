//
//  MyAdventuresTableViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 28.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import UIKit

class MyAdventuresTableViewController: UITableViewController {
    // MARK: Global vars
    // current logged user
    var user: User?
    var createdAdventures: [Adventure] = []
    var joinedAdventures: [Adventure] = []
    // queue
    lazy var myAdventuresQueue: NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "My adventures queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My adventures"
        
        self.user = currentUser()
        
        var refresher: UIRefreshControl = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "updateData:", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresher
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        fetchUserAdventuresDataFromAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch (section) {
        case 0:
            return createdAdventures.count
        case 1:
            return joinedAdventures.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "My adventures"
        case 1:
            return "Joined adventures"
        default:
            return "Default header"
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyAdventuresCell", forIndexPath: indexPath) as! UITableViewCell

        switch(indexPath.section) {
        case 0:
            cell.textLabel?.text = "created"
        case 1:
            cell.textLabel?.text = "joined"
        default:
            cell.textLabel?.text = "Default"
        }

        return cell
    }
    
    func updateData(sender: AnyObject) {
        fetchUserAdventuresDataFromAPI()
    }
    
    func fetchUserAdventuresDataFromAPI() {
        var url: String = api_url + "/user/get/adventures" + "?user_id=" + String(user!.id)
        var request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: self.myAdventuresQueue, completionHandler: {(
            response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult == nil) {
                // display alert with error
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView(title: "Error occured", message: "Internal error. Please try again", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    
                    // stop refreshing
                    self.refreshControl!.endRefreshing()
                }
                
                return
            }
            
            // handle jsonResult "error"
            if (jsonResult["error"] != nil) {
                // display error
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView(title: "Something Went Wrong", message: jsonResult["error"] as? String, delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    
                    // stop refreshing
                    self.refreshControl!.endRefreshing()
                }
                
                return
            }
            
            // load adventures
            dispatch_async(dispatch_get_main_queue()) {
                self.createdAdventures.removeAll(keepCapacity: true)
                self.joinedAdventures.removeAll(keepCapacity: true)
                
                // add adventures to created_adventures
                for (_, adventureData) in jsonResult["created"] as! NSDictionary {
                    // get adventure participants
                    var participants: [(id: Int64, username: String)] = []
                    for (_, participantData) in adventureData["participants"] as! NSDictionary {
                        participants.append((
                            id: participantData["id"]!!.longLongValue as Int64,
                            username: participantData["username"] as! String
                        ))
                    }
                    
                    self.createdAdventures.append(
                        Adventure(
                            id: adventureData["id"]!!.longLongValue as Int64,
                            creator_id: adventureData["creator_id"]!!.longLongValue as Int64,
                            creator_username: adventureData["creator_username"] as! String,
                            date: adventureData["date"]!!.longValue as Int,
                            info: adventureData["info"] as! String,
                            joined: adventureData["joined"]!!.longValue as Int,
                            participants: participants,
                            image_url: adventureData["static_image_url"] as! String
                        )
                    )
                }
                
                // add adventures to joined_adventures
                for (_, adventureData) in jsonResult["joined"] as! NSDictionary {
                    // get adventure participants
                    var participants: [(id: Int64, username: String)] = []
                    for (_, participantData) in adventureData["participants"] as! NSDictionary {
                        participants.append((
                            id: participantData["id"]!!.longLongValue as Int64,
                            username: participantData["username"] as! String
                        ))
                    }
                    
                    self.joinedAdventures.append(
                        Adventure(
                            id: adventureData["id"]!!.longLongValue as Int64,
                            creator_id: adventureData["creator_id"]!!.longLongValue as Int64,
                            creator_username: adventureData["creator_username"] as! String,
                            date: adventureData["date"]!!.longValue as Int,
                            info: adventureData["info"] as! String,
                            joined: adventureData["joined"]!!.longValue as Int,
                            participants: participants,
                            image_url: adventureData["static_image_url"] as! String
                        )
                    )
                }
                
                // update view
                self.tableView.reloadData()
                
                // stop refreshing
                self.refreshControl!.endRefreshing()
            }
        })
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController is AdventureDetailViewController) {
            let adventureDetailController: AdventureDetailViewController = segue.destinationViewController as! AdventureDetailViewController
            
            let path: NSIndexPath = sender as! NSIndexPath
            switch(path.section) {
            case 0:
                adventureDetailController.adventure = self.createdAdventures[path.row]
            case 1:
                adventureDetailController.adventure = self.joinedAdventures[path.row]
            default:
                adventureDetailController.adventure = nil
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showAdventureDetails", sender: indexPath)
    }
}
