//
//  AdventuresViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import Foundation
import UIKit

class AdventuresViewController: UICollectionViewController {
    // MARK: Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
   
    // MARK: Global vars
    // all adventures
    var adventures: [Adventure]?
    // refresher
    var refreshControl: UIRefreshControl!
    
    // connection queue
    lazy var allAdventuresQueue: NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "All adventures queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    // MARK: - Main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Adventures"
        
        // activity indicator have to hide when stopped
        // self.activityIndicator.hidesWhenStopped = true
        
        self.adventures = [
            Adventure(
                id: 1,
                creator_id: 1,
                creator_username: "1",
                date: Int(NSDate().timeIntervalSince1970),
                info: "Some informations about this adventure",
                joined: 1,
                participants: [(id: 2, username: "Tomek")],
                image_url: ""
            )
        ]
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.collectionView?.addSubview(refreshControl)

        // update all adventures
        updateAdventures()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        
//        updateAdventures()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.adventures!.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var date: String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:MM"
            let date: NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(self.adventures![indexPath.row].date))
            return dateFormatter.stringFromDate(date)
        }
        
        
        let adventuresCell = collectionView.dequeueReusableCellWithReuseIdentifier("AdventuresCell", forIndexPath: indexPath) as! AdventuresCollectionCell
        adventuresCell.infoLabel.text = self.adventures![indexPath.row].info
        adventuresCell.dateLabel.text = date
        adventuresCell.joinedLabel.text = String(self.adventures![indexPath.row].joined)
        adventuresCell.staticImage.image = self.adventures![indexPath.row].getStaticImage()
        
        return adventuresCell as AdventuresCollectionCell
    }
    
    // MARK: - Navigation segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController is AdventureDetailViewController) {
            let adventureDetailController: AdventureDetailViewController = segue.destinationViewController as! AdventureDetailViewController
            
            let row: Int = sender as! Int
            adventureDetailController.adventure = self.adventures![row]
        }
        
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showAdventureDetails", sender: indexPath.row)
    }
    
    // MARK: - Custom functions
    /**
        Refreshes adventures
    
        :param: sender Object which triggers refreshing
    */
    func refresh(sender: AnyObject) {
        updateAdventures()
    }
    
    
    /**
        Updates all adventures
        Gets data from api and update them to view controller
    */
    func updateAdventures() {
        var url: String = api_url + "/adventure/get/all"
        var request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        // start animating indicator
        if (!self.refreshControl.refreshing) {
            self.activityIndicator.startAnimating()
        }
        
        NSURLConnection.sendAsynchronousRequest(request, queue: self.allAdventuresQueue, completionHandler: {(
            response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary

            if (jsonResult == nil) {
                // display alert with error
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView(title: "Error occured", message: "Internal error. Please try again", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    
                    // stop animating indicator
                    if (self.activityIndicator.isAnimating()) {
                        self.activityIndicator.stopAnimating()
                    }
                    
                    // stop refreshing
                    if (self.refreshControl.refreshing) {
                        self.refreshControl.endRefreshing()
                    }
                }
                
                return
            }
            
            // load adventures
            dispatch_async(dispatch_get_main_queue()) {
                for (_, adventureData) in jsonResult {
                    // get adventure participants
                    var participants: [(id: Int64, username: String)] = []
                    for (_, participantData) in adventureData["participants"] as! NSDictionary {
                        participants.append((
                            id: participantData["id"]!!.longLongValue as Int64,
                            username: participantData["username"] as! String
                        ))
                    }
                    
                    self.adventures?.removeAll(keepCapacity: true)
                    self.adventures?.append(
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
                self.collectionView?.reloadData()
                
                // stop animating indicator
                if (self.activityIndicator.isAnimating()) {
                    self.activityIndicator.stopAnimating()
                }
                
                // stop refreshing
                if (self.refreshControl.refreshing) {
                    self.refreshControl.endRefreshing()
                }
            }
        })
    }
}
