//
//  SignUpVC.swift
//  Login
//
//  Created by Fareen on 1/22/18.
//  Copyright © 2018 Fareen. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SignUpVC: UIViewController {

    @IBOutlet weak var nameTxtField: RoundTextField!
    @IBOutlet weak var emailTxtField: RoundTextField!
    @IBOutlet weak var pwdTxtField: RoundTextField!
    @IBOutlet weak var rePwdTxtField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Mark: - IBAction

    @IBAction func signUpBtnPressed(_ sender: RoundButton) {
        guard let name = nameTxtField.text, name.characters.count > 0 else {
            showAlert(title: "Name is Required!", message: "You must enter name.")
            
            return
        }
        
        guard let email = emailTxtField.text, email.characters.count > 0 else {
            showAlert(title: "Email is Required!", message: "You must enter email.")

            return
        }
        
        guard let password = pwdTxtField.text, password.characters.count > 0 else {
            showAlert(title: "Password is Required!", message: "You must enter password.")

            return
        }
        
        guard let rePassword = rePwdTxtField.text, (rePassword.characters.count > 0 && rePassword == password) else {
            showAlert(title: "Re-Enter Password is Required!", message: "You must enter the same password in re-enter password field.")

            return
        }
        
        AuthService.instance.signUp(name: name, email: email, password: password, onComplete: { (errMsg, data) in
            guard errMsg == nil else {
                self.showAlert(title: "Error Authentication", message: errMsg!)

                return
            }

            self.completeLogin(id: "\(data!)")
        })
        
    }
    
    @IBAction func alreadyHaveAccountBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    
    func completeLogin(id: String) {
        let _ = KeychainWrapper.standard.set(id, forKey: KEY_UID)

        performSegue(withIdentifier: "showNewsFeedVC", sender: nil)
    }
    
}


