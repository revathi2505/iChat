//
//  ViewController.swift
//  Chat
//
//  Created by Easyway_Mac2 on 12/06/19.
//  Copyright © 2019 Easyway_Mac2. All rights reserved.
//

import UIKit
import ProgressHUD

class WelcomeVC: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var repeatPasswordTextField: UITextField!
    
    private let welcomeToRegisterSegueId = "WelcomeToRegister"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        dismissKeyboard()
        
        if emailTextField.text != nil && passwordTextField.text != nil {
            
            FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
                
                if error != nil {
                    ProgressHUD.showError("\(error?.localizedDescription)")
                }
                
                
            }
            
        } else {
            ProgressHUD.showError("Email and password are missing")
        }
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        dismissKeyboard()
        
        if emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != "" {
            
            if passwordTextField.text == repeatPasswordTextField.text
            {
                registerUser()
            }
            else
            {
                ProgressHUD.showError("Passwords do not match!!")
            }
            
        } else {
            ProgressHUD.showError("All field's are required!!")
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    private func cleanTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        repeatPasswordTextField.text = ""
    }
    
    
    private func registerUser() {
        performSegue(withIdentifier: welcomeToRegisterSegueId, sender: self)
        
        cleanTextFields()
        dismissKeyboard()
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == welcomeToRegisterSegueId
        {
            if let registerVC = segue.destination as? RegisterVC {
                registerVC.email = emailTextField.text!
                registerVC.password = passwordTextField.text!
            }
   
        }
    }
    
}

