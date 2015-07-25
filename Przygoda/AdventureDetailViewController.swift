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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details " + String(adventure!.id)
        // Do any additional setup after loading the view.
        
        // enable buttons
        self.joinItem.enabled = true
        self.editItem.enabled = adventure!.id == 1
        self.deleteItem.enabled = adventure!.id == 2
        
        // delegate bar
        self.bar.delegate = self
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if (item.title == "Join") {
            print("Join button tapped")
        } else if (item.title == "Edit") {
            print("Edit button tapped")
        } else if (item.title == "Delete") {
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
