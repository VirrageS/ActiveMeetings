//
//  AdventureDetailContainerViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 27.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import UIKit
import Foundation

class AdventureDetailContainerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Detail info outlets
    @IBOutlet var map: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var creatorUsernameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var joinedLabel: UILabel!
    
    @IBOutlet var participantsTableView: UITableView!
    
    // MARK: - Global vars
    var adventure: Adventure? // opened adventure

    
    // MARK: - Main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate tableView
        self.participantsTableView.delegate = self
        self.participantsTableView.dataSource = self

        updateAdventureDetailInfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.adventure!.participants.count
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Participants"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let participantCell = tableView.dequeueReusableCellWithIdentifier("ParticipantCell", forIndexPath: indexPath) as! AdventureDetailTableViewCell
        participantCell.participantUsernameLabel.text = self.adventure!.participants[indexPath.row].username
        return participantCell
    }
    
    // MARK: - Custom functions
    /**
        Updates adventure info
    */
    func updateAdventureDetailInfo() {
        // update labels
        self.map.image = self.adventure?.getStaticImage()
        self.infoLabel.text = self.adventure?.info
        self.creatorUsernameLabel.text = self.adventure?.creator_username
        self.dateLabel.text = self.adventure?.getFormattedDate()
        self.joinedLabel.text = String(self.adventure!.joined)
        
        // update rest
        self.participantsTableView.reloadData()
        self.updateTableViewSize()
    }
    
    /**
        Updates size of table view and content view.
    */
    func updateTableViewSize() {
        dispatch_async(dispatch_get_main_queue()) {
            self.participantsTableView.frame.size.height = self.participantsTableView.contentSize.height
            self.view.frame.size.height = self.participantsTableView.frame.maxY
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
