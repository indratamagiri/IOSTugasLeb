//
//  RegisController.swift
//  ProjectLab
//
//  Created by user on 15/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class RegisController: UIViewController, UITextFieldDelegate {
    
    var datas = [Users]()
    var email_unic = ""

    @IBAction func cancle(_ sender: Any) {
        let alert = UIAlertController(title: "Cancle", message: "Are You Sure To Cancle?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in self.performSegue(withIdentifier: "Cancle", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func Register(_ sender: Any) {
        
        fetchData();
        var message = ""
        for data in datas {
            email_unic = data.email!
            if email.text == email_unic {
                message = "Email have been used"
            }
        }
        if email.text == "" {
            message = "Input Email"
        }
        else if !validateEmail(enteredEmail: (email.text)!){
            message = "Input Email Error"
        }
        else if password.text == "" {
            message = "Input Password"
        }
        else if cnfPassword.text == "" {
            message = "Input Confrim Password"
        }
        else if password.text != cnfPassword.text! {
            message = "Password must be same"
        }
        else if !(address.text?.hasSuffix("Street"))!{
            message = "Address must have street"
        }else if telp.text == ""{
            message = "telp must be filled"
        }
         if message == ""{
            message = "Register success"
            let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                action in self.performSegue(withIdentifier: "Cancle", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
            insertData();
        }else {
            let alert = UIAlertController(title: "Failed", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cnfPassword: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var telp: UITextField!
    
    
    override func viewDidLoad() {
        email.delegate = self
        password.delegate = self
        cnfPassword.delegate = self
        address.delegate = self
        telp.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
        }else if textField == password {
            cnfPassword.resignFirstResponder()
        }else if textField == cnfPassword {
            address.resignFirstResponder()
        }else if textField == address {
            telp.resignFirstResponder()
        }else if textField == telp {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func insertData(){
        let user = Users(context: context)
        
        user.email = email.text
        user.password = password.text
        user.address = address.text
        user.telp = telp.text
        
        appDelegate.saveContext()
    }
    
    func fetchData() {
        do {
            datas = try context.fetch(Users.fetchRequest())
        }catch {
            
        }
    }
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }


}
