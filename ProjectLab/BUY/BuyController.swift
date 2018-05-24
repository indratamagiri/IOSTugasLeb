//
//  BuyController.swift
//  ProjectLab
//
//  Created by user on 22/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class BuyController: UIViewController {
    
    var buyUser = Buy()
    var orders = [Order]()
    var date: NSDate?
    var name: String?
    var pizzaName: String?

    
    @IBOutlet weak var buyUI: UIButton!
    @IBOutlet weak var editorder: UIButton!
    @IBOutlet weak var topping: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var pizName: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var pricelbl: UILabel!
    
    
    
    @IBAction func BuyBtn(_ sender: Any) {
        do {
            orders = try context.fetch(Order.fetchRequest())
            for order in orders {
                if order.name ==  name && order.date_order == date && order.pizzaName == pizzaName{
                context.delete(order)
                    let alert = UIAlertController(title: "Buy Success", message: "Suc", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.performSegue(withIdentifier: "backMenu", sender: self)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } catch {
            print(Error.self)
        }

}
    
   
    @IBAction func editOrderBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "editOrderUser", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        load()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func load(){
        buyUI.layer.cornerRadius = 4
        editorder.layer.cornerRadius = 4
        img.layer.cornerRadius = 4
        img.image = UIImage(named: buyUser.pizzaName!)
        size.text = buyUser.size
        self.navigationItem.title = "Buy Order"
        qty.text = String(buyUser.qty)
        pricelbl.text = String(buyUser.price)
        pizName.text = buyUser.pizzaName
        toppingtext();
        
    }
    
    func fetchData(){
        do {
            orders = try context.fetch(Order.fetchRequest())
            for order in orders {
                if order.name ==  name && order.date_order == date && order.pizzaName == pizzaName{
                    buyUser.date_order = order.date_order
                    buyUser.name = order.name
                    buyUser.pizzaName = order.pizzaName
                    buyUser.size = order.size
                    buyUser.price = order.price
                    buyUser.qty = Int(order.qty)
                    buyUser.toppingMoz = order.toppingMoz
                    buyUser.toppingMush = order.toppingMush
                    buyUser.toppingPin = order.toppingPin
                    buyUser.toppingPap = order.toppingPap
                }
            }
        } catch {
            
        }
    }
    
    func toppingtext(){
        if buyUser.toppingMoz == true {
            buyUser.topping = "Mozzalera"
        }
        if buyUser.toppingMush == true {
            buyUser.topping = "\(buyUser.topping ?? "") Mushroom"
        }
        if buyUser.toppingPin == true {
            buyUser.topping = "\(buyUser.topping ?? "") Pinapple"
        }
        if buyUser.toppingPap == true {
            buyUser.topping = "\(buyUser.topping ?? "") Papperoni"
        }
        topping.text = buyUser.topping
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editOrderUser"{
        let det = segue.destination as! EditController
        det.date = buyUser.date_order
        det.nama = buyUser.name!
        det.pizzaName = buyUser.pizzaName!
        }
    }
}
