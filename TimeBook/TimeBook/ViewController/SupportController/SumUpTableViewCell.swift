//
//  SumUpTableViewCell.swift
//  TimeBook
//
//  Created by Hoang Duc on 8/1/19.
//  Copyright © 2019 Hoang Duc. All rights reserved.
//

import UIKit

class SumUpTableViewCell: UITableViewCell {

    @IBOutlet weak var doneTxt: UITextField!
    @IBOutlet weak var notDoneTxt: UITextField!
    @IBOutlet weak var mediTime: UITextField!
    @IBOutlet weak var mediCoffee: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
