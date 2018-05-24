//
//  MenuPizzaCell.swift
//  ProjectLab
//
//  Created by user on 16/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MenuPizzaCell: UITableViewCell {

    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.border.layer.cornerRadius = 10
        self.border.layer.borderWidth = 4
        self.border.layer.borderColor = UIColor(red: 177/255, green: 255/255, blue: 176/255, alpha: 0.5).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
