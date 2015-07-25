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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
   
    var adventures: [Adventure]?
    
    lazy var allAdventuresQueue: NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "All adventures queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Adventures"
        
        // activity indicator have to hide when stopped
        self.activityIndicator.hidesWhenStopped = true
        
        self.adventures = [
            Adventure(id: 1, creator_id: 1, creator_username: "1", joined: 1, date: NSDate(), participants: [(id: 2, username: "Tomek")], image_url: "")
        ]
        
        var url: String = api_url + "/adventure/get/all"
        var request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        // start animating indicator
        self.activityIndicator.startAnimating()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: self.allAdventuresQueue, completionHandler: {(
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
                    
                    self.adventures?.append(
                        Adventure(
                            id: adventureData["id"]!!.longLongValue as Int64,
                            creator_id: adventureData["creator_id"]!!.longLongValue as Int64,
                            creator_username: adventureData["creator_name"] as! String,
                            joined: adventureData["joined"]!!.longLongValue as Int64,
                            date: NSDate(timeIntervalSince1970: NSTimeInterval(adventureData["date"] as! Int)),
                            participants: participants,
                            image_url: adventureData["static_image_url"] as! String
                        )
                    )
                }
                
                // update view
                self.collectionView?.reloadData()
                
                // stop animating indicator
                self.activityIndicator.stopAnimating()
            }
        })
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
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return dateFormatter.stringFromDate(self.adventures![indexPath.row].date)
        }
        
        
        let adventuresCell = collectionView.dequeueReusableCellWithReuseIdentifier("AdventuresCell", forIndexPath: indexPath) as! AdventuresCollectionCell
        adventuresCell.joinedLabel.text = String(self.adventures![indexPath.row].joined)
        adventuresCell.dateLabel.text = date
        adventuresCell.staticImage.image = self.adventures![indexPath.row].getStaticImage()
        
        return adventuresCell as AdventuresCollectionCell
    }
    
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
}
