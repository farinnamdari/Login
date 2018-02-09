//
//  NewsFeedVC.swift
//  Login
//
//  Created by Fareen on 1/30/18.
//  Copyright © 2018 Fareen. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper

class NewsFeedVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - IBAction
    
    @IBAction func signOutBtnTapped(_ sender: UIButton) {
        let _ = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "showLoginVC", sender: nil)
    }
    

}
