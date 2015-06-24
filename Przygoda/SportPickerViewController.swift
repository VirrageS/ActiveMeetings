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
        
        self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 216/255, green: 192/255, blue: 53/255, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 22)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
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
        cell.textLabel!.textColor = UIColor(red: 126/255, green: 186/255, blue: 179/255, alpha: 1.0)
        cell.textLabel!.font = UIFont(name: "AvenirNext", size: 15)
        return cell
    }
}