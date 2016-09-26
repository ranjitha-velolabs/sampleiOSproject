//
//  ListDetailsTableViewCell.swift
//  Skyshare_ios
//
//  Created by Ranjitha on 9/25/16.
//  Copyright © 2016 Ranjitha. All rights reserved.
//

import UIKit

class ListDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var distance_Lbl: UILabel!
    @IBOutlet weak var fleet_name_Lbl: UILabel!
    @IBOutlet weak var hour_lbl: UILabel!
    
    @IBOutlet weak var rate_Lbl: UILabel!
    
    @IBOutlet weak var label_count_Lbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
