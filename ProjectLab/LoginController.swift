//
//  LoginController.swift
//  ProjectLab
//
//  Created by user on 16/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var orders = [Order]()

    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    @IBOutlet weak var menuBtn: UIButton!
    
    
    @IBAction func menuPizza(_ sender: Any) {
         performSegue(withIdentifier: "menuPizza", sender: self)
    }
    
    @IBAction func orderUser(_ sender: Any) {
         performSegue(withIdentifier: "orderUser", sender: self)
    }
    
    @IBAction func editProfile(_ sender: Any) {
        performSegue(withIdentifier: "profileEdit", sender: self)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //addOrderTable()
        //fetchData()
        menuBtn.layer.cornerRadius = 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

}
