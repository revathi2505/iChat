//
//  RegisterVC.swift
//  Chat
//
//  Created by Easyway_Mac2 on 01/07/19.
//  Copyright © 2019 Easyway_Mac2. All rights reserved.
//

import UIKit
import ProgressHUD

class RegisterVC: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var phoneNoTextField: UITextField!
    
    @IBOutlet var avatarImageView: UIImageView!
    
    var email: String!
    var password: String!
    
    var avatarImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismissKeyboard()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        dismissKeyboard()
        ProgressHUD.show()
        
        if nameTextField.text != nil && surnameTextField.text != nil && countryTextField.text != nil && cityTextField.text != nil && phoneNoTextField.text != nil {
            
            FUser.registerUserWith(email: email, password: password, firstName: nameTextField.text!, lastName: surnameTextField.text!) { (err) in
                
                ProgressHUD.dismiss()
                
                if err != nil {
                    return
                }
                
                self.registerUser()
            }
            
        }
        
        
    }
    
    private func dismissKeyboard() {
         self.view.endEditing(false)
    }
    
    private func registerUser() {
        
        let name = nameTextField.text! + " " + surnameTextField.text!
        
        var tempDict: Dictionary = [kFIRSTNAME: nameTextField.text!, kLASTNAME: surnameTextField.text!,kFULLNAME: name, kCOUNTRY: countryTextField.text!, kCITY: cityTextField.text!, kPHONE: phoneNoTextField.text!] as [String : Any]
        
        if avatarImage == nil {
            
            imageFromInitials(firstName: nameTextField.text!, lastName: surnameTextField.text!) { (avatarImage) in
                
                self.avatarImage = avatarImage
            }
        }
        
        if let avatarImageData = avatarImage?.jpegData(compressionQuality: 0.7) {
            
            let avatar = avatarImageData.base64EncodedString(options: .init(rawValue: 0))
            tempDict[kAVATAR] = avatar
        }
        
        updateCurrentUserInFirestore(withValues: tempDict) { (err) in
            if err != nil {
                print(err)
                return
            }
        }
    }

}
