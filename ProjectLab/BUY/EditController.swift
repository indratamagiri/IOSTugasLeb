//
//  EditController.swift
//  ProjectLab
//
//  Created by user on 22/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class EditController: UIViewController {
    var orders = [Order]()
    var editOrder = Buy()
    var nama = ""
    var date: NSDate?
    var pizzaName = ""
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var pep: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var editOrderUI: UIButton!
    @IBOutlet weak var mus: UIImageView!
    @IBOutlet weak var pin: UIImageView!
    @IBOutlet weak var moz: UIImageView!
    @IBOutlet weak var sizeUI: UIButton!
    @IBOutlet weak var qtyUI: UIButton!
    @IBOutlet weak var headUI: UIView!
    @IBOutlet weak var imgUI: UIView!
    
    @IBAction func EditOrder(_ sender: Any) {
        let alert = UIAlertController(title: "Change Order", message: "Are you sure to change order", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.editData()
            self.performSegue(withIdentifier: "OrderUser", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func qtyBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Jumlah Pesanan", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = String(self.editOrder.qty)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                if  let textField:Int = Int((alert?.textFields![0].text)!) {
                    if (textField) <= 0 {
                        self.alertOrder(msg: "Quantity must more that 0")
                    }
                    else if textField >= 9 {
                        self.alertOrder(msg: "Quantity less that 9")
                    }
                    else {
                        self.qtyLbl.text = String(textField);
                        self.editOrder.qty = Int(self.qtyLbl.text!)!
                        self.updatePrice()
                    }
                }else {
                    self.alertOrder(msg: "Quantity must numberic")
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func SizeBtn(_ sender: Any) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please select Size", message: "Option to select", preferredStyle: .actionSheet)
        
        let smallActionButton = UIAlertAction(title: "Small", style: .default) { _ in
            self.sizeLbl.text = "Small"
            self.editOrder.sizePrice = 0.75
            self.updatePrice()
        }
        actionSheetControllerIOS8.addAction(smallActionButton)
        
        let mediumActionButton = UIAlertAction(title: "Medium", style: .default)
        { _ in
            self.sizeLbl.text = "Medium"
            self.editOrder.sizePrice = 1.0
            self.updatePrice()
        }
        actionSheetControllerIOS8.addAction(mediumActionButton)
        
        let largeActionButton = UIAlertAction(title: "Large", style: .default)
        { _ in
            self.sizeLbl.text = "Large"
            self.editOrder.sizePrice = 1.5
            self.updatePrice()
           
        }
        actionSheetControllerIOS8.addAction(largeActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
       load()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    func fetchData(){
        do {
            orders = try context.fetch(Order.fetchRequest())
            for order in orders {
                if order.name ==  nama && order.date_order == date && order.pizzaName == pizzaName{
                    editOrder.date_order = order.date_order
                    editOrder.name = order.name
                    editOrder.pizzaName = order.pizzaName
                    editOrder.size = order.size
                    editOrder.price = order.price
                    editOrder.qty = Int(order.qty)
                    editOrder.toppingMoz = order.toppingMoz
                    editOrder.toppingMush = order.toppingMush
                    editOrder.toppingPin = order.toppingPin
                    editOrder.toppingPap = order.toppingPap
                }
            }
        } catch {
            
        }
    }
    func load(){
        imgUI.layer.cornerRadius = 5
        img.layer.cornerRadius = 5
        qtyUI.layer.cornerRadius = 5
        sizeUI.layer.cornerRadius = 5
        editOrderUI.layer.cornerRadius = 5
        img.image = UIImage(named: editOrder.pizzaName!)
        namelbl.text = editOrder.pizzaName
        qtyLbl.text = String(editOrder.qty)
        sizeLbl.text = editOrder.size
        priceLbl.text = String(editOrder.price)
        imgGestur(img: moz)
        imgGestur(img: mus)
        imgGestur(img: pep)
        imgGestur(img: pin)
        if editOrder.toppingMoz! {
            toppingload(img: moz)
        }
        if editOrder.toppingPin! {
            toppingload(img: pin)
        }
        if editOrder.toppingMush! {
            toppingload(img: mus)
        }
        if editOrder.toppingPap! {
            toppingload(img: pep)
        }
        editOrder.setSizePrice()
       
    }
    
    func toppingload(img: UIImageView){
        img.layer.cornerRadius = 5
        img.layer.borderWidth = 5
        img.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
         Editopping(add: true, imgTopping: img)
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
            Editopping(add: true, imgTopping: tappedImage)
        } else if tappedImage.layer.cornerRadius == 0{
            tappedImage.layer.cornerRadius = 5
            tappedImage.layer.borderWidth = 5
            tappedImage.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
            Editopping(add: true, imgTopping: tappedImage)
        } else {
            tappedImage.layer.cornerRadius = 0
            tappedImage.layer.borderWidth = 0
            tappedImage.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0).cgColor
            Editopping(add: false, imgTopping: tappedImage)
        }
    }
    
    func Editopping(add: Bool, imgTopping: UIImageView)  {
        if add && imgTopping == moz {
            editOrder.toppingMoz = true
            editOrder.addTopping(addToping: 2.0)
            updatePrice();
        }else  if !add && imgTopping == moz {
            editOrder.toppingMoz = false
            editOrder.remTopping(remToping: 2.0)
            updatePrice();
        }
        if add && imgTopping ==  mus{
            editOrder.toppingMush = true
            editOrder.addTopping(addToping: 2.0)
            updatePrice();
        }else if !add && imgTopping == mus {
            editOrder.toppingMush = true
            editOrder.remTopping(remToping: 2.0)
            updatePrice();
        }
        if add && imgTopping == pin {
            editOrder.toppingPin = true
            editOrder.addTopping(addToping: 2.0)
            updatePrice();
        }else  if !add && imgTopping == pin {
            editOrder.toppingPin = false
            editOrder.remTopping(remToping: 2.0)
            updatePrice();
        }
        if add && imgTopping == pep {
            editOrder.toppingPap = true
            editOrder.addTopping(addToping: 2.0)
            updatePrice();
        }else if !add && imgTopping == pep {
            editOrder.toppingPap = false
            editOrder.remTopping(remToping: 2.0)
            updatePrice();
        }
        
    }
    
    func alertOrder(msg: String){
        let alert = UIAlertController(title: "Pesanan Ditolak", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func updatePrice(){
        var total = 0.0
        let prizePizza = editOrder.pizzaPrice()
        total = ((prizePizza + editOrder.toppingPrice) * editOrder.sizePrice) * Double(editOrder.qty)
        priceLbl.text = String(format: "%.2f", ceil(total*100)/100)
    }
    
    func editData(){
        do {
            orders = try context.fetch(Order.fetchRequest())
            for order in orders {
                if order.name ==  nama && order.date_order == date && order.pizzaName == pizzaName{
                    order.qty = Int32(qtyLbl.text!)!
                    order.size = sizeLbl.text
                    order.toppingPap = editOrder.toppingPap!
                    order.toppingPin = editOrder.toppingPin!
                    order.toppingMush = editOrder.toppingMush!
                    order.toppingMoz = editOrder.toppingMoz!
                    order.price = Double(priceLbl.text!)!
                    do{
                        try context.save()
                    }
                    catch
                    {
                        print(error)
                    }
                }
            }
        }catch {
            
        }
    }
    
    
}
