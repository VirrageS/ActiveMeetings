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
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let sport = sports[indexPath.row] as Sport
                (segue.destinationViewController as! ModePickerViewController).sport = sport
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
        return cell
    }
}