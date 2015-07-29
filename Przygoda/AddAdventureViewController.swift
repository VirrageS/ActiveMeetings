//
//  AddAdventureViewController.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 29.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import UIKit

class AddAdventureViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var adventureTypePicker: UIPickerView!
    @IBOutlet var dataPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.adventureTypePicker.delegate = self
        self.adventureTypePicker.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AdventureTypes.values.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return AdventureTypes.values[row].type.rawValue
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
