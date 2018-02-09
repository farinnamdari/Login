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
            self.notifyUser(title: "Name is Required!", message: "You must enter name.")
            return
        }
        
        guard let email = emailTxtField.text, email.characters.count > 0 else {
            self.notifyUser(title: "Email is Required!", message: "You must enter email.")
            return
        }
        
        guard let password = pwdTxtField.text, password.characters.count > 0 else {
            self.notifyUser(title: "Password is Required!", message: "You must enter password.")
            return
        }
        
        guard let rePassword = rePwdTxtField.text, (rePassword.characters.count > 0 && rePassword == password) else {
            self.notifyUser(title: "Re-Enter Password is Required!",
                            message: "You must enter the same password in re-enter password field.")
            return
        }
        
        AuthService.instance.signUp(name: name, email: email, password: password, onComplete: { (errMsg, data) in
            guard errMsg == nil else {
                self.notifyUser(title: "Error Authentication", message: errMsg!)
                return
            }
            // perform segue to destination VC
            self.completeLogin(id: "\(86)")
        })
        
    }
    
    @IBAction func alreadyHaveAccountBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    
    func completeLogin(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        
        
        print("keychainResult: \(keychainResult)")
        print("id:\(id)")
        // perform segue to destination VC
        performSegue(withIdentifier: "showNewsFeedVC", sender: nil)
    }
    
    func notifyUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// refactor alert

