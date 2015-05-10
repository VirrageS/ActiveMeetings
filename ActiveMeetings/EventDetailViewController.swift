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
            self.updateTitle()
        }
    }
    
    func updateTitle() {
        if let event: Event = self.event {
            self.title = event.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.updateTitle()
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 216/255, green: 192/255, blue: 53/255, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 22)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
    }

    
    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = "Hello"
        cell.textLabel!.textColor = UIColor(red: 126/255, green: 186/255, blue: 179/255, alpha: 1.0)
        cell.textLabel!.font = UIFont(name: "AvenirNext", size: 15)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ogólne"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}