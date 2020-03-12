//
//  FarmViewController.swift
//  Grub Growers
//
//  Created by Nadia Goodlet on 11/03/2020.
//  Copyright © 2020 Nadia Goodlet. All rights reserved.
//

import UIKit
import FirebaseAuth

class FarmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // Sign Out Button takes user back to Login Page if successful
    @IBAction func signOut_TouchUpInside(_ sender: Any) {
        
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError {
            print(signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(identifier: "LoginVC")
        show(loginVC, sender: nil)
       
    }
  

}
