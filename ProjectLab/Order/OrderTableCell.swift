//
//  OrderTableCell.swift
//  ProjectLab
//
//  Created by user on 18/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class OrderTableCell: UITableViewCell {

    
    @IBOutlet weak var pizzaName: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var qtyPizza: UILabel!
    @IBOutlet weak var pricePizza: UILabel!
    @IBOutlet weak var borderUI: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       img.layer.cornerRadius = 7
        self.borderUI.layer.cornerRadius = 7
        self.borderUI.layer.borderWidth = 4
        self.borderUI.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 0.5).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
