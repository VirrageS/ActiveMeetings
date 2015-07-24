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
    var adventures: [Adventure]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Adventures"
        
        self.adventures = [
            Adventure(id: 1, creator_id: 1, creator_name: "1", joined: 1, date: NSDate()),
            Adventure(id: 2, creator_id: 2, creator_name: "2", joined: 2, date: NSDate()),
            Adventure(id: 3, creator_id: 3, creator_name: "3", joined: 3, date: NSDate()),
            Adventure(id: 3, creator_id: 3, creator_name: "3", joined: 3, date: NSDate()),
            Adventure(id: 3, creator_id: 3, creator_name: "3", joined: 3, date: NSDate()),
            Adventure(id: 3, creator_id: 3, creator_name: "3", joined: 3, date: NSDate()),
            Adventure(id: 3, creator_id: 3, creator_name: "3", joined: 3, date: NSDate())
        ]
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
