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
    
    @IBOutlet weak var menuLayout: UIView!
    @IBOutlet weak var orderLayout: UIView!
    
    
    @objc func menuAction(_ sender:UITapGestureRecognizer){
        // do other task
        print("Succses")
         performSegue(withIdentifier: "menuPizza", sender: self)
    }
    
    @objc func orderAction(_ sender:UITapGestureRecognizer){
        // do other task
        print("Succses")
         performSegue(withIdentifier: "orderUser", sender: self)
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func load(){
        let gestureMenu = UITapGestureRecognizer(target: self, action:  #selector(self.menuAction))
        self.menuLayout.addGestureRecognizer(gestureMenu)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.orderAction))
        self.orderLayout.addGestureRecognizer(gesture)
        
        menuLayout.layer.cornerRadius = 6
        orderLayout.layer.cornerRadius = 6
    }
    
    

}
