//
//  OrderTableController.swift
//  ProjectLab
//
//  Created by user on 18/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CoreData

class OrderTableController:UITableViewController{
    var orders = [Order]()
    var tam = userOrder()
    var userbuy = UserBuy()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Your Order"
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    
    func fetchData(){
        let user =  UserDefaults.standard.string(forKey: "defaultUser")
        print(user)
        do {
           orders = try context.fetch(Order.fetchRequest())
                for order in orders {
                    if order.name ==  user{
                        tam.orders.append(order)
                        print(order)
                    }
                }
        } catch {
                
            }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tam.orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderPizza", for: indexPath) as! OrderTableCell
        let name = self.tam.orders[indexPath.row].value(forKey: "pizzaName") as! String
        let price = self.tam.orders[indexPath.row].value(forKey: "price") as! Double
        let qty = self.tam.orders[indexPath.row].value(forKey: "qty") as! Int32
        cell.pizzaName.text = name
        cell.img.image = UIImage(named: name)
        cell.pricePizza.text = String(price)
        cell.qtyPizza.text = String(qty)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
            if editingStyle == .delete {
                    let selectedManagedObject = self.tam.orders[indexPath.row]
                    deleteData(deleteObject: selectedManagedObject)
                    tam.orders.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    print("Deleted")
            }
    }
    
    func deleteData(deleteObject:NSManagedObject){
        context.delete(deleteObject)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! BuyController
        dest.date = userbuy.date_order
        dest.name = userbuy.name
        dest.pizzaName = userbuy.pizzaName
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userbuy.date_order = self.tam.orders[indexPath.row].value(forKey: "date_order") as? NSDate
        userbuy.name = self.tam.orders[indexPath.row].value(forKey: "name") as? String
        userbuy.pizzaName = self.tam.orders[indexPath.row].value(forKey: "pizzaName") as? String
        self.performSegue(withIdentifier: "buyUser", sender: self)
    }
    @IBAction func prepareFor(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }

}
