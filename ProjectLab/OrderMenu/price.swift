//
//  price.swift
//  ProjectLab
//
//  Created by user on 19/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class Price {
    var qty = 1.0
    var pizzaPrice = 0.0
    var Size = 1.0
    var Topping = 0.0
    
    func updatePrice()-> String{
        var total = 0.0
        total = ((pizzaPrice + Topping) * Size) * qty
        return String(format: "%.2f", ceil(total*100)/100)
    }
    
    func addTopping(addToping: Double){
        Topping += addToping
    }
    func remTopping(remToping: Double){
        Topping -= remToping 
    }
}
