//
//  AdventureDetailViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import UIKit

class AdventureDetailViewController: UIViewController, UITabBarDelegate {
    // MARK: tabBar outlets
    @IBOutlet var bar: UITabBar!
    @IBOutlet var joinItem: UITabBarItem!
    @IBOutlet var editItem: UITabBarItem!
    @IBOutlet var deleteItem: UITabBarItem!
    
 
    // MARK: info outlets
    @IBOutlet var map: UIImageView!
    
    // MARK: global vars
    var adventure: Adventure? // opened adventure
    var user: User? // current logged user
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set adventure title
        self.title = "Details " + String(adventure!.id)
        
        // get current logged user
        user = currentUser()
        
        
        // MARK: tabBar init
        
        // enable buttons
        self.joinItem.enabled = adventure!.creator_id != user!.id
        self.editItem.enabled = adventure!.creator_id == user!.id
        self.deleteItem.enabled = adventure!.creator_id == user!.id
        
        // change title of join/leave item
        var hasJoined: Bool = false
        for participant in adventure!.participants {
            if (participant.id == user!.id) {
                hasJoined = true
                break
            }
        }
        self.joinItem.title = hasJoined ? "Leave" : "Join"
        
        // MARK: info init
        
        // update static map image
        self.map.image = self.adventure?.getStaticImage()
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if (item == joinItem) {
            print("Join button tapped")
        } else if (item == editItem) {
            print("Edit button tapped")
        } else if (item == deleteItem) {
            print("Delete button tapped")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
