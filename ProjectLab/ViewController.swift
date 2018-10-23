//
//  ViewController.swift
//  ProjectLab
//
//  Created by user on 15/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var datas = [Users]()
    
    @IBOutlet weak var loginBorder: UIView!
    @IBOutlet weak var regisDesign: UIButton!
    @IBOutlet weak var loginDesign: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func login(_ sender: Any) {
        if validate() {
            let defaultUser = UserDefaults.standard
            defaultUser.set(email.text, forKey: "defaultUser")
            performSegue(withIdentifier: "Login", sender: self)
        }else {
            let alert = UIAlertController(title: "Login Failed", message: "Incorrect password and email", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func register(_ sender: Any) {
         performSegue(withIdentifier: "RegisShow", sender: self)
    }
    
    override func viewDidLoad() {
        email.delegate = self
        password.delegate = self
        super.viewDidLoad()
        btnDesign();
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
        }else if textField == password {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func fetchData() {
        do {
            datas = try context.fetch(Users.fetchRequest())
        }catch {
            
        }
    }
    
    func validate() -> Bool {
        fetchData();
        for data in datas {
            if email.text == data.email && password.text == data.password{
                return true
            }
        }
        return false
    }
    
    func btnDesign() {
        loginDesign.layer.cornerRadius = 6
        regisDesign.layer.cornerRadius = 6
        self.loginBorder.layer.cornerRadius = 7
        self.loginBorder.layer.borderWidth = 4
        self.loginBorder.layer.borderColor = UIColor(red: 177/255, green: 255/255, blue: 176/255, alpha: 0.5).cgColor
        
    }
    
    @IBAction func prepareForLogin(segue: UIStoryboardSegue) {
        
    }

}
