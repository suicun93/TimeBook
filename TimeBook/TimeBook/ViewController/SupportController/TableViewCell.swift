//
//  TableViewCell.swift
//  TimeBook
//
//  Created by Hoang Duc on 7/26/19.
//  Copyright © 2019 Hoang Duc. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var chamNgonLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

}
