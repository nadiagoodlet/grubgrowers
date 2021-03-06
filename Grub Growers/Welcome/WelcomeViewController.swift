//
//  WelcomeViewController.swift
//  Grub Growers
//
//  Created by Nadia Goodlet on 10/03/2020.
//  Copyright © 2020 Nadia Goodlet. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
   
    @IBOutlet weak var signUpButton: UIButton!
    
 
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loginStyle()
        signUpstyle()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
             // Checking if the user is alrady logged in / not nil
                  if Auth.auth().currentUser != nil {
                      // If user is not nil, transiton straight to HomeVC
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let homeVC = storyboard.instantiateViewController(identifier: "HomeVC") as? UITabBarController {
                        show(homeVC, sender: nil)
//
                    }
                          
//
                  }
           
        // Checking if the user has already seen the walktrhough screens
           if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough"){
               return
           }
           
           let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
           if let walkthroughViewController = storyboard.instantiateViewController(identifier: "WalkthroughViewController") as? WalkthroughViewController {
               present(walkthroughViewController, animated: true, completion: nil)
           }
        
       
        
       }
    
    
    
    func loginStyle() {
        
        // Rounded corners on login button
               let path = UIBezierPath(roundedRect: self.loginButton.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
                  let maskLayer = CAShapeLayer()
                  maskLayer.frame = self.loginButton.bounds
                  maskLayer.path = path.cgPath
                  self.loginButton.layer.mask = maskLayer
        
    }
    
    func signUpstyle() {
        
        // Rounded corners on sign up button
               let path = UIBezierPath(roundedRect: self.signUpButton.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
                   let maskLayer = CAShapeLayer()
                   maskLayer.frame = self.signUpButton.bounds
                   maskLayer.path = path.cgPath
                   self.signUpButton.layer.mask = maskLayer
               
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
