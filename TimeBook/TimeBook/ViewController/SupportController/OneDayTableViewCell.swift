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
    @IBOutlet weak var plusText: UITextView!
    @IBOutlet weak var toDoTxt: UITextView!
    @IBOutlet weak var minusTxt: UITextView!
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        hourTxt.text = ""
        meditationTxt.text = ""
        plusText.text = ""
        minusTxt.text = ""
        toDoTxt.text = ""
    }
}
