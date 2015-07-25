//
//  AdventureDetailViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import UIKit

class AdventureDetailViewController: UIViewController, UITabBarDelegate {
    @IBOutlet var joinItem: UITabBarItem!
    @IBOutlet var editItem: UITabBarItem!
    @IBOutlet var deleteItem: UITabBarItem!
    @IBOutlet var bar: UITabBar!
 
    var adventure: Adventure?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details " + String(adventure!.id)
        // Do any additional setup after loading the view.
        
        // get current logged user
        user = currentUser()
        
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

        // delegate bar
        self.bar.delegate = self
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
