//
//  ViewController.swift
//  FireApp
//
//  Created by KO on 23.08.2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var paswordField: UITextField!


    @IBAction func signInButton(_ sender: UIButton) {
        if let email = emailField.text {
            Auth.auth().signIn(withEmail: email, password: paswordField.text! , completion: { (user,error) in
                if error == nil {
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                   self.performSegue(withIdentifier: "goInside",sender: nil)
                }
            
            
            })
        
        
        }
    }
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        //let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        let keychainResult = KeychainWrapper.defaultKeychainWrapper.set(id, forKey: "uid")
        print("JESS: Data saved to keychain \(keychainResult)")
    }
}

