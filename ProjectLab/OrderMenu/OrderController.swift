//
//  OrderController.swift
//  ProjectLab
//
//  Created by user on 17/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class OrderController: UIViewController, UIActionSheetDelegate {
    
    let price = Price();
    
    var pizzaName:String?
    var pizzaimg:UIImage?
    var pizzaprice:Int?
    
    var toppingMoz = ""
    var toppingMush = ""
    var toppingPin = ""
    var toppingPap = ""
    var namaUser = ""
    
    @IBOutlet weak var imgUI: UIImageView!
    @IBOutlet weak var lblUI: UILabel!
    @IBOutlet weak var borderUI: UIView!
    @IBOutlet weak var QtyUI: UIButton!
    @IBOutlet weak var SizeUI: UIButton!
    @IBOutlet weak var ToppingUI: UIView!
    @IBOutlet weak var OrderUI: UIButton!
    
    @IBOutlet weak var Sizelbl: UILabel!
    @IBOutlet weak var Qtylbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    
    @IBOutlet weak var morzzalle: UIImageView!
    @IBOutlet weak var pinapple: UIImageView!
    @IBOutlet weak var mushroom: UIImageView!
    @IBOutlet weak var Papperoni: UIImageView!
    
    
    
    @IBAction func orderBtn(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Input your order name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Input Name"
            
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
             if  let textField:String = alert?.textFields![0].text {
                if  let x:String = textField {
                    self.namaUser = x
                    if self.Sizelbl.text == "-" {
                        self.alertOrder(msg: "Choose Pizza size")
                    } else if Int(self.Qtylbl.text!)! > 9 || Int(self.Qtylbl.text!)! <= 0{
                        self.alertOrder(msg: "Input Pizza quantity")
                    }
                    else {
                         self.insertData()
                       self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
                    }
                }else{
                    self.namaUser = "";
                }
                }
            }))
       
        self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func QtyBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Order Total", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Input order total"
            
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if  let textField:Int = Int((alert?.textFields![0].text)!) {
                if (textField) <= 0 {
                    self.alertOrder(msg: "Quantity must be more that 0")
                }
                else if textField >= 9 {
                    self.alertOrder(msg: "Quantity must be less that 9")
                }
                else {
                    self.Qtylbl.text = String(textField);
                    self.price.qty = Double(textField);
                    self.updatePrice();
                }
            }else {
                self.alertOrder(msg: "Quantity must be in numeric form")
            }
        }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func Sizebtn(_ sender: Any) {
        actionSheetOrder();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func load(){
        imgUI.image = pizzaimg
        lblUI.text = pizzaName
        self.navigationItem.title = "Order Pizza"
        orderUI();
        imgGestur(img: morzzalle);
        imgGestur(img: mushroom);
        imgGestur(img: pinapple);
        imgGestur(img: Papperoni);
        price.pizzaPrice = Double(pizzaprice!)
        updatePrice();
    }
    
    
    func orderUI(){
        QtyUI.layer.cornerRadius = 6
        lblUI.text = pizzaName
        SizeUI.layer.cornerRadius = 6
        OrderUI.layer.cornerRadius = 6
        ToppingUI.layer.cornerRadius = 6
        self.borderUI.layer.cornerRadius = 7
        self.borderUI.layer.borderWidth = 4
        self.borderUI.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 0.5).cgColor
        
    }
    
    
    func alertOrder(msg: String){
        let alert = UIAlertController(title: "Order is declined", message: msg, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func actionSheetOrder(){
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please select Size", message: "Option to select", preferredStyle: .actionSheet)
        
        let smallActionButton = UIAlertAction(title: "Small", style: .default) { _ in
            self.Sizelbl.text = "Small"
            self.price.Size = 0.75
            self.updatePrice()
        }
        actionSheetControllerIOS8.addAction(smallActionButton)
        
        let mediumActionButton = UIAlertAction(title: "Medium", style: .default)
        { _ in
            self.Sizelbl.text = "Medium"
            self.price.Size = 1.0
            self.updatePrice()
        }
        actionSheetControllerIOS8.addAction(mediumActionButton)
        
        let largeActionButton = UIAlertAction(title: "Large", style: .default)
        { _ in
            self.Sizelbl.text = "Large"
            self.price.Size = 1.5
            self.updatePrice()
        }
        actionSheetControllerIOS8.addAction(largeActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    
    func imgGestur(img: UIImageView ){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
    let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if tappedImage.layer.borderColor == nil {
        tappedImage.layer.cornerRadius = 5
        tappedImage.layer.borderWidth = 5
        tappedImage.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
            addTopping(add: true, imgTopping: tappedImage)
        } else if tappedImage.layer.cornerRadius == 0{
            tappedImage.layer.cornerRadius = 5
            tappedImage.layer.borderWidth = 5
            tappedImage.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
            addTopping(add: true, imgTopping: tappedImage)
        } else {
            tappedImage.layer.cornerRadius = 0
            tappedImage.layer.borderWidth = 0
            tappedImage.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0).cgColor
            addTopping(add: false, imgTopping: tappedImage)
        }
    }

    func addTopping(add: Bool, imgTopping: UIImageView)  {
        if add && imgTopping == morzzalle {
           toppingMoz = "Mozzarella"
            price.addTopping(addToping: 2.0)
            updatePrice();
        }else  if !add && imgTopping == morzzalle {
            toppingMoz = ""
            price.remTopping(remToping: 2.0)
            updatePrice();
        }
        if add && imgTopping == mushroom {
            toppingMush = "Mushroom"
            price.addTopping(addToping: 2.0)
            updatePrice();
        }else if !add && imgTopping == mushroom {
            toppingMush = ""
            price.remTopping(remToping: 2.0)
            updatePrice();
        }
        if add && imgTopping == pinapple {
            toppingPin = "Pinapple"
            price.addTopping(addToping: 2.0)
            updatePrice();
        }else  if !add && imgTopping == pinapple {
            toppingPin = ""
            price.remTopping(remToping: 2.0)
            updatePrice();
        }
        if add && imgTopping == Papperoni {
            toppingPap = "Papperoni"
            price.addTopping(addToping: 2.0)
            updatePrice();
        }else if !add && imgTopping == Papperoni {
            toppingPap = ""
            price.remTopping(remToping: 2.0)
            updatePrice();
        }
       
    }
    
    func insertData(){
        let order = Order(context: context)
        if let name = UserDefaults.standard.string(forKey: "defaultUser") {
            order.name = name
            order.qty = Int32(Qtylbl.text!)!
            order.date_order = Date() as NSDate
            order.price = Double(price.updatePrice())!
            order.pizzaName = pizzaName
            order.size = Sizelbl.text
            if toppingMoz == "Mozzarella"{
               order.toppingMoz = true
            }else {
                order.toppingMoz = false
            }
            if toppingMush == "Mushroom"{
               order.toppingMush = true
            }else {
                order.toppingMush = false
            }
            if toppingPin == "Pinapple"{
               order.toppingPin = true
            }else {
                order.toppingPin = false
            }
            if toppingPap == "Papperoni"{
                order.toppingPap = true
            }else {
                order.toppingPap = false
            }
            appDelegate.saveContext()
        }
    }
    
    func updatePrice(){
        pricelbl.text = price.updatePrice()
    }
    
    
}
