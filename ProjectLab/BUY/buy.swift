//
//  buy.swift
//  ProjectLab
//
//  Created by user on 22/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class Buy{
    var date_order: NSDate?
    var name: String?
    var pizzaName: String?
    var size: String?
    var price = 0.0
    var qty = 0
    var toppingMoz: Bool?
    var toppingMush: Bool?
    var toppingPin: Bool?
    var toppingPap: Bool?
    var topping: String?
    var toppingPrice = 0.0
    var sizePrice = 0.0
    
    func pizzaPrice() -> Double{
        if pizzaName == "American Favourite" {
            return 25
        }
        if pizzaName == "Black Papper" {
            return 20
        }
        if pizzaName == "Cheeseburger" {
            return 18
        }
        if pizzaName == "Deluxe Cheese" {
            return 25
        }
        if pizzaName == "Frankturter BBQ" {
            return 30
        }
    return 0
    }
    
    func setSizePrice(){
        if size == "Small" {
            sizePrice = 0.75
        }
        if size == "Medium" {
            sizePrice = 1.0
        }
        if size == "Large" {
            sizePrice = 1.5
        }
        
    }
    
    func addTopping(addToping: Double){
        toppingPrice += addToping
    }
    func remTopping(remToping: Double){
        toppingPrice -= remToping
    }
}



