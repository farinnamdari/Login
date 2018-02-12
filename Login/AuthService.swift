//
//  AuthService.swift
//  Login
//
//  Created by Fareen on 1/19/18.
//  Copyright © 2018 Fareen. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.handelFirebaseError(err: error!, onComplete: onComplete)
            } else {
                //print("uid using currentUser: \(Auth.auth().currentUser?.uid)")
                onComplete?(nil, user!.uid as AnyObject?)
            }
        }
    }
    
    func signUp(name: String, email: String, password: String, onComplete: Completion?) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.handelFirebaseError(err: error!, onComplete: onComplete)
            } else {
                if user?.uid != nil {
                    let userData = ["name": name, "email": email]
                    
                    onComplete?(nil, user!.uid as AnyObject?) // might not need it here
                    DataService.instance.updateFirebaseUser(uid: user!.uid, userData: userData)
                }
            }
        }
    }
    
    func handelFirebaseError(err: Error, onComplete: Completion?) {
        print(err.localizedDescription)
        
        if let errCode = AuthErrorCode(rawValue: err._code) {
            switch errCode {
            case .userNotFound:
                onComplete?("User does not exist!", nil)
                break
            case .invalidEmail:
                onComplete?("Invalid email address!", nil)
                break
            case .wrongPassword:
                onComplete?("Invalid password!", nil)
            case .emailAlreadyInUse:
                onComplete?("Cannot create an account. Email already in used!", nil)
                break
            case .accountExistsWithDifferentCredential:
                onComplete?("Cannot create an account. Account already exists with different credentials!", nil)
                break
            case .weakPassword:
                onComplete?("Weak Password! Password's length has to be 6 or more.", nil)
                break
            default:
                print("Error: \(err.localizedDescription)")
                
                onComplete?("There was a problem authenticating. Try again!", nil)
            }
        }
    }
}

