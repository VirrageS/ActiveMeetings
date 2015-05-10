//
//  EventDetailViewController.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 10.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import Foundation
import UIKit

class EventDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var event: Event? {
        didSet {
            // Update the view.
//            self.updateTitle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.title = "Detale"
//        self.updateTitle()
        
        //self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 216/255, green: 192/255, blue: 53/255, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 22)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
    }

    
    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! UITableViewCell
        
        var text: String = ""
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                text = event!.name
            case 1:
                text = event!.description
            case 2:
                text = String(stringInterpolationSegment: event?.coordinate)
            default:
                text = "Default"
            }
        case 1:
            switch indexPath.row {
            case 0:
                text = event!.creator
            case 1:
                text = "Dołączyło już " + String(event!.pariticipants) + " osób"
            default:
                text = "Default"
            }
        default:
            text = "Default"
        }
        
        cell.textLabel!.text = text
        cell.textLabel!.textColor = UIColor(red: 126/255, green: 186/255, blue: 179/255, alpha: 1.0)
        cell.textLabel!.font = UIFont(name: "AvenirNext", size: 15)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Ogólne"
        case 1:
            return "Założyciel"
        default:
            return "Default Section Title"
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}