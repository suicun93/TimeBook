//
//  OneDayTableViewCell.swift
//  TimeBook
//
//  Created by Hoang Duc on 7/30/19.
//  Copyright © 2019 Hoang Duc. All rights reserved.
//

import UIKit

class OneDayTableViewCell: UITableViewCell {

    @IBOutlet weak var hourTxt: UITextField!
    @IBOutlet weak var meditationTxt: UITextField!
    @IBOutlet weak var plusText: UITextField!
    @IBOutlet weak var minusTxt: UITextField!
    @IBOutlet weak var toDoTxt: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

}
