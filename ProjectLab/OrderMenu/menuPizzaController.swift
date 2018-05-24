//
//  menuPizzaController.swift
//  ProjectLab
//
//  Created by user on 16/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class menuPizzaController: UITableViewController {

    var PizzaName:[String] = [];
    var PizzaImg:[UIImage] = [];
    var PizzaPrice:[Int] = [];
    
    var select_PizzaName:String?
    var select_PizzaImg:UIImage?
    var select_pizzaprice:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMenu()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMenu() {
        PizzaName = ["American Favourite", "Black Papper", "Cheeseburger", "Deluxe Cheese", "Frankturter BBQ"]
        PizzaImg = [#imageLiteral(resourceName: "American Favourite"), #imageLiteral(resourceName: "Black Papper"), #imageLiteral(resourceName: "Cheeseburger"), #imageLiteral(resourceName: "Deluxe Cheese"), #imageLiteral(resourceName: "Frankturter BBQ")]
        PizzaPrice = [25, 20, 18, 25, 30]
        tableView.delegate = self
        tableView.delegate = self
        self.navigationItem.title = "Pizza Menu"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PizzaImg.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pizzaMenu", for: indexPath) as! MenuPizzaCell
        cell.Img.image = PizzaImg[indexPath.row]
        cell.lbl.text = PizzaName[indexPath.row]
        cell.price.text = String(PizzaPrice[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        select_PizzaName = PizzaName[indexPath.row]
        select_PizzaImg = PizzaImg[indexPath.row]
        select_pizzaprice = PizzaPrice[indexPath.row]
         self.performSegue(withIdentifier: "selectPizza", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let det = segue.destination as! OrderController
        det.pizzaName = select_PizzaName;
        det.pizzaimg = select_PizzaImg;
        det.pizzaprice = select_pizzaprice;
    }
}
