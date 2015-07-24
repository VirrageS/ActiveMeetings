//
//  AdventuresCell.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import UIKit

class AdventuresCollectionCell: UICollectionViewCell {
    @IBOutlet var joinedLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1.0).CGColor
    }
}
