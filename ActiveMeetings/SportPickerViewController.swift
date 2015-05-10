//
//  SportPickerViewController.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 10.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import Foundation
import UIKit

class SportPickerViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sport"
    }

    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMode" {
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
        return sports.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sportCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = sports[indexPath.row].name
        return cell
    }
}