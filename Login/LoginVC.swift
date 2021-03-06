//
//  ViewController.swift
//  Login
//
//  Created by Fareen on 1/18/18.
//  Copyright © 2018 Fareen. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxtField: RoundTextField!
    @IBOutlet weak var pwdTxtField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let keychain = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print(keychain)
            performSegue(withIdentifier: "showNewsFeedVC", sender: nil)
        }
    }

    // MARK: - IBAction
    
    @IBAction func LoginBtnPressed(_ sender: RoundButton) {
        if let email = emailTxtField.text, let password = pwdTxtField.text, (email.characters.count > 0 && password.characters.count > 0)  {
            AuthService.instance.login(email: email, password: password, onComplete: { (errMsg, data) in
                guard errMsg == nil else {
                    self.showAlert(title: "Error Authentication", message: errMsg!)
                    
                    return
                }

                self.completeLogin(id: "\(data!)")
            })
        } else {
            showAlert(title: "Username and Password are Required!", message: "You must enter both username and password.")
        }
    }

    @IBAction func createAccountBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showSignUpVC", sender: sender)
    }
    
    // MARK: - Helper Functions
    
    func completeLogin(id: String) {
        let _ = KeychainWrapper.standard.set(id, forKey: KEY_UID)

        performSegue(withIdentifier: "showNewsFeedVC", sender: nil)
    }
}

