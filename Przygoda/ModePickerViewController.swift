//
//  ModePickerViewController.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 10.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import Foundation
import UIKit

class ModePickerViewController: UITableViewController {
    var sport: Sport? {
        didSet {
            // Update the view.
            self.updateTitle()
        }
    }
    
    func updateTitle() {
        if let sport: Sport = self.sport {
            self.title = sport.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTitle()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 216/255, green: 192/255, blue: 53/255, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 22)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let mode = self.sport!.modes[indexPath.row] as Mode
                (segue.destinationViewController as! MapViewController).mode = mode
            }
        }
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sport!.modes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("modeCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = self.sport!.modes[indexPath.row].name
        cell.textLabel!.textColor = UIColor(red: 126/255, green: 186/255, blue: 179/255, alpha: 1.0)
        cell.textLabel!.font = UIFont(name: "AvenirNext", size: 15)
        return cell
    }
}